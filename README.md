# Journal

<!-- TOC GitLab -->

* [Features](#features)
* [Design](#design)
* [Task management](#task-management)
* [Journaling](#journaling)
* [Setup](#setup)
* [Development](#development)
* [Notes](#notes)

<!-- /TOC -->

**Journal** is a place to organize your life and get things done. It is an agnostic approach to note management and personal organization.

![$ journal find](https://github.com/lbcnz/journal/raw/master/journal-fzf.png) 

## Features
- A journaling helper *(to take notes like a Starfleet captain)*.
- Task management with markdown notes without effort.
- Fuzzy search for TODOs in your files.

## Design
- Notes are short named [markdown](markdown.md) files and thus can be viewed and edited in any text editor and easily exported to any format.
- Assets are images, documents and other files linked inside notes.
- Hyperlinks are the glue that connects everything into a meaningful knowledge base.
- Tasks are lines in notes that start with the `TODO:` placeholder, a common convention. 
- Log entries are time named notes that are merged and archived after some time.
- Scripts automates trivial tasks and creates useful functionality that goes beyond pen and paper or conventional text editing.
- Notes are contained in plain text files inside directories. What fits under the same scope is put in the same subdirectory.
- Besides file system, it's stateless and safe to use with version control systems and file syncing tools.
- Journal preserve tasks contexts. By not pulling task management away from their context of execution it improves feedback, learning and value delivery evaluation.
- Journal is interoperable with any text editor and is more an agnostic personal organization system than a software.

## Task management
Manage tasks, keep track and archive them after they are done.

**How to use**
- `journal show` print the tasks to stdout in plain text;
- `journal print` show the tasks in a pager with pretty formatting;
- `journal find` search tasks in fzf with note preview;
- `journal commit` clean done tasks and write them to journal.

Commit function will post-call `git commit -m $today_date`.

Search binds:
- `F1` opens task note with `xdg-open`
- `F2` opens task note in `$EDITOR`
- `F3` cycles task priority tag 
- `DEL` deletes the task

**Syntax**
Priority
- +asap
- +later
- +done

Context
- #house
- #linux

People
- @danisztls

## Journaling
Aids in the management a markdown diary and saves time that would be spent with file naming and copy/paste.

**How to use**
- `journal write` open a new entry in a text editor.
- `journal read` fuzzy browse among entries.
- `journal rotate` rotate old entries into monthly/yearly notes.

It expects notes saved in **YY-MM-DD.md**, **YY-MM.md** and **YY.md** format and will ignore other files. The default retention policy is 15 days for daily entries and 6 months for monthly entries.

## Setup
Run the **setup** script to install it in home. Dependencies are **ripgrep**, **fzf** and **bat**.

## Development
Feedback and contributions are welcomed. Development info at [DEVELOPMENT.md](https://gitlab.com/lbcnz/journal/-/blob/master/DEVELOPMENT.md).

## Notes
**Contained**: Assets should, preferably, be contained in the same directory as it parent note. If they are stored somewhere else it will be painful to move the note without breaking links. Also Electron based text editors, like Visual Studio, will not allow access to assets outside root directory of file. In other words, preview will be broken.

**Hierarchical**: Tags are popular nowadays and really useful but file systems are hierarchical and I am sticking with it. Although you can still tag your notes and use content search to find tagged notes, you can even put everything inside a single directory.

**Interoperability**: Agnosticism, botttom-up approach, form follows functions, minimalism and modularity are principles that guide its development.

