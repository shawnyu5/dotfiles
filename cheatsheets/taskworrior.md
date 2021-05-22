<!-- vim-markdown-toc GFM -->

* [add a task](#add-a-task)
* [add a project](#add-a-project)
	* [showing tasks only from a project](#showing-tasks-only-from-a-project)
	* [adding tasks to a project](#adding-tasks-to-a-project)
* [tags](#tags)
	* [put the wrong tag](#put-the-wrong-tag)
	* [searching for tags](#searching-for-tags)
* [assign ID to task](#assign-id-to-task)
* [delete a task](#delete-a-task)
* [add due date](#add-due-date)
* [putting it all together](#putting-it-all-together)
* [mark you are starting a task](#mark-you-are-starting-a-task)
* [change priority](#change-priority)
* [contexts](#contexts)
	* [creating contexts](#creating-contexts)
	* [switching between contexts](#switching-between-contexts)
	* [list all contexts](#list-all-contexts)
	* [show current context](#show-current-context)
	* [clear current context](#clear-current-context)
* [dependencies](#dependencies)
* [filters](#filters)
* [recurring tasks](#recurring-tasks)
* [until](#until)
* [wait](#wait)
* [schedule](#schedule)
* [searching for tasks](#searching-for-tasks)
	* [by name (regular expression)](#by-name-regular-expression)
* [annotations/ notes](#annotations-notes)
	* [deleting a annotation](#deleting-a-annotation)
* [Burndown](#burndown)

<!-- vim-markdown-toc -->

**NOTE** task has been aliased to t

# add a task

`task add`

# add a project

`task add project:fixing the house`

## showing tasks only from a project

`task project:<project name>`

## adding tasks to a project

`task add <task name> project:<project name>`

# tags

`task add shopping +lifestyle`

putting + signfies a tag

## put the wrong tag

instead of **lifestyle**, you meant to type **people**?

`tag +LATEST modify -lifestyle +people`

## searching for tags

`task +<tag name>`

# assign ID to task

`task ID modify project:home`

# delete a task

`task delete ID`

# add due date

`task ID modify due:31st`

# putting it all together

`task add oop-workshop project:seneca due:3/12`
# mark you are starting a task

`task ID start`

# change priority

`task ID modify priority:M`

Priory are listed as:

1. High.
2. Medium.
3. Low.
4. None (default).

# contexts

**context aliased to c**

## creating contexts

`task context define <context_name> project:<project/ tag name>`

show only tasks from the added projects/ tags

`task context define <context_name> project.not:<project_name>`

exclude certain projects

## switching between contexts

`task context <context name>`

switches to the selected context

## list all contexts

`task context list`

## show current context

`task context show`

## clear current context

`task context none`

# dependencies

`task ID modify depends:OTHER_ID`

      Try not to have large, long-term tasks that will sit on your list
      forever. It can be very satisfying and motivating to complete tasks, so
      create more, but smaller, tasks. Don't have a 'learn Japanese' task,
      instead have a 'Complete chapter 1' task instead, it's more readily
      achievable, and you can more easily see progress, which can be
      motivating.

Having a task depend on another means the dependencies will have to be complete
before starting that task

# filters

`task entry.after:today-4days list`

shows tasks added from today to 4 days ago

`task entry:yesterday list`

shows tasks added yesterday

`task end.after:2015-05-01 and end.before:2015-05-31 completed`

completed tasks in a date range

# recurring tasks

`task add Do the thing due:2015-06-08T09:00 recur:weekly`

I want to make a task that is due at 9:00am every Monday,
starting this coming Monday.

`task add Pay rent due:28th recur:monthly until:now+1yr`

I want a reminder to pay the rent every month, but only
for a year.

# until

`task <id> modify until:<date>`

Will delete the task after that date has passed, if the
task is not complete

# wait

`task <id> modify wait:+5d`

**Wait** 5 days to **show** me this task

`task <id> modify wait:tomorrow`

Wait until tomorrow to show me this task

`task <id> modify wait:2021-05-22`

Could also pass in absolute dates

# schedule

`task <id> modify schedule:date`

this task will receive an urgency boost after the scheduled date

# searching for tasks

## by name (regular expression)

`task /<task name>/ <action>`

ie:
`task /home work/ done`

# annotations/ notes

`task <ID> annotate "<annotation>"`

## deleting a annotation

`task <ID> denotate`

# Burndown

Displays a chart shows the completed tasks during that week.

By default, it shows burndown chart for the week. But the command can be
modified to month `task burndown.monthly` or `task burndown.daily`
