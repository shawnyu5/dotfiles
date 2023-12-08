package main

import (
	"bytes"
	"fmt"
	"log"
	"os"
	"os/exec"
	"strings"
	"time"

	"github.com/go-git/go-git/v5"
	"github.com/go-git/go-git/v5/config"
	"github.com/go-git/go-git/v5/plumbing"
	"github.com/go-git/go-git/v5/plumbing/object"
	"github.com/go-git/go-git/v5/plumbing/transport/http"
)

func main() {
	branches := []string{"main", "windows", "work_laptop", "hp_laptop"}
	os.RemoveAll("/tmp/personal")

	// r, err := git.PlainOpen("/tmp/personal")
	r, err := git.PlainClone("/tmp/personal", false, &git.CloneOptions{
		URL:      "https://github.com/shawnyu5/dotfiles",
		Progress: os.Stdout,
	})
	if err != nil {
		log.Fatal("Error cloning repo:", err)
	}

	os.Chdir("/tmp/personal")
	// cmd := exec.Command("")
	// ref, err := r.Head()
	if err != nil {
		log.Fatal(err)
	}

	// ogBranchName := ref.Name().Short()
	getOgBranchName := exec.Command("git", "rev-parse", "--abbrev-ref", "HEAD")
	var ogBranchNameBuffer bytes.Buffer
	getOgBranchName.Stdout = &ogBranchNameBuffer
	getOgBranchName.Run()
	ogBranchName := ogBranchNameBuffer.String()
	ogBranchName = strings.TrimSpace(ogBranchName)

	branches = removeElement(branches, ogBranchName)

	w, err := r.Worktree()
	if err != nil {
		log.Fatal("Unable to get worktree:", err)
	}

	err = w.Checkout(&git.CheckoutOptions{
		Branch: plumbing.ReferenceName("refs/heads/main"),
		Create: false,
		Keep:   true,
	})

	if err != nil {
		log.Fatal("Unable to checkout to main branch:", err)
	}

	// refs, _ := r.References()
	// refs.ForEach(func(ref *plumbing.Reference) error {
	//    if ref.Type() == plumbing.HashReference {
	//       fmt.Println(ref)
	//    }
	//    return nil
	// })

	// return

	for _, branch := range branches {
		log.Printf("Syncing config from `%s` to `%s`", ogBranchName, branch)

		// command to checkout config files from og branch into current branch
		checkoutFiles := exec.Command("git", "checkout", ogBranchName, ".config/nvim", ".zshrc", ".zsh_aliases", "ansible", "utils/", ".config/starship.toml", ".tmux.conf", "config_sync")

		err = exec.Command("git", "checkout", branch).Run()
		if err != nil {
			log.Fatalf("Unable to checkout branch `%s`: %s", branch, err)
		}

		// err = w.Checkout(&git.CheckoutOptions{
		//    Branch: plumbing.ReferenceName(fmt.Sprintf("refs/remotes/origin/%s", branch)),
		// })
		// if err != nil {
		//    log.Fatalf("Unable to checkout branch `%s`: %s", branch, err)
		// }

		err = checkoutFiles.Run()
		if err != nil {
			log.Fatal("Error checking out files: ", err)
		}

		_, err = w.Commit(fmt.Sprintf("chore: sync config from %s", ogBranchName), &git.CommitOptions{
			AllowEmptyCommits: false,
			Author: &object.Signature{
				Name:  "Shawn Yu",
				Email: "shawn.yu@githubnoreply.com",
				When:  time.Now(),
			},
		})
		if err != nil {
			log.Fatal("Error committing updated config:", err)
		}

		err = r.Push(&git.PushOptions{
			RemoteName: "origin",
			Auth: &http.BasicAuth{
				Username: "shawnyu5",
				Password: getPAT(),
			},
			RefSpecs: []config.RefSpec{
				config.RefSpec(fmt.Sprintf("refs/heads/%s:refs/heads/%s", branch, branch)),
			},
			Progress: os.Stdout,
		})
		if err != nil {
			log.Fatal("Failed to push to branch:", err)
		}
	}
}

// getPAT Read Github personal access token from `~/.git-credentials`
func getPAT() string {
	// TODO: consider getting token using `gh auth token`
	homeDir, err := os.UserHomeDir()
	if err != nil {
		log.Fatal("Failed to get user home directory:", err)
	}
	gitCredentials, err := os.ReadFile(homeDir + "/.git-credentials")
	if err != nil {
		log.Fatal("Failed to read git credentials:", err)
	}
	firstLine := strings.Split(string(gitCredentials), "\n")[0]
	pat := strings.Replace(firstLine, "https://shawnyu5:", "", 1)
	pat = strings.Replace(pat, "@github.com", "", 1)
	return pat
}

// removeElement Removes an element from a slice
func removeElement(slice []string, element string) []string {
	// Find the index of the element to remove
	index := -1
	for i, v := range slice {
		if v == element {
			index = i
			break
		}
	}

	// If the element is not found, return the original slice
	if index == -1 {
		return slice
	}
	// Remove the element by creating a new slice without it
	return append(slice[:index], slice[index+1:]...)
}
