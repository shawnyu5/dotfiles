package main

import (
	"bytes"
	"fmt"
	"os"
	"os/exec"
	"strings"
	"time"

	"github.com/charmbracelet/log"
	"github.com/go-git/go-git/v5"
	"github.com/go-git/go-git/v5/config"
	"github.com/go-git/go-git/v5/plumbing"
	"github.com/go-git/go-git/v5/plumbing/object"
	"github.com/go-git/go-git/v5/plumbing/transport/ssh"
)

func main() {
	branches := []string{"main", "windows", "work_laptop", "hp_laptop"}
	os.RemoveAll("/tmp/personal")

	ogBranchName := currentPersonalCheckedOutBranch()
	// println(ogBranchName)

	auth, err := ssh.NewPublicKeysFromFile("git", os.Getenv("HOME")+"/.ssh/id_ed25519_personal", "")
	if err != nil {
		log.Fatalf("failed to read SSH key: %s", err)
	}

	log.Info("Cloning repo...")
	r, err := git.PlainClone("/tmp/personal", false, &git.CloneOptions{
		URL:           "git@github-personal:shawnyu5/dotfiles.git",
		Auth:          auth,
		ReferenceName: plumbing.ReferenceName("refs/heads/" + ogBranchName),
	})
	if err != nil {
		log.Fatal("Error cloning repo:", err)
	}

	branches = removeElement(branches, ogBranchName)

	w, err := r.Worktree()
	if err != nil {
		log.Fatal("Unable to get worktree:", err)
	}

	os.Chdir("/tmp/personal")
	for _, branch := range branches {
		log.Infof("Syncing config from `%s` to `%s`", ogBranchName, branch)

		// command to checkout config files from og branch into current branch
		checkoutFiles := exec.Command("git", "checkout", ogBranchName, ".config/nvim", ".zshrc", ".zsh_aliases", "ansible", "utils/", ".config/starship.toml", ".tmux.conf", "config_sync", ".config/gh", "work_history.md")

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

		log.Info("Committing changes")
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

		log.Info("Pushing changes to remote")
		err = r.Push(&git.PushOptions{
			RemoteName: "origin",
			Auth:       auth,
			// Auth: &http.BasicAuth{
			// 	Username: "shawnyu5",
			// 	Password: getPAT(),
			// },
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

// currentPersonalCheckedOutBranch get the current branch that is checked out at `~/personal`
func currentPersonalCheckedOutBranch() string {
	homeDir, err := os.UserHomeDir()
	if err != nil {
		log.Fatal(err)
	}

	os.Chdir(fmt.Sprintf("%s/personal", homeDir))
	getOgBranchName := exec.Command("git", "rev-parse", "--abbrev-ref", "HEAD")

	var ogBranchNameBuffer bytes.Buffer
	getOgBranchName.Stdout = &ogBranchNameBuffer
	getOgBranchName.Run()
	ogBranchName := ogBranchNameBuffer.String()
	ogBranchName = strings.TrimSpace(ogBranchName)
	return ogBranchName

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
