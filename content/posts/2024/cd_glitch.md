+++
title = "cd glitch?????"
date = "2024-01-12T16:00:17-06:00"
author = ""
authorTwitter = "" #do not include @
cover = "/img/confused.jpg"
tags = ["terminal", "linux"]
keywords = ["", ""]
description = ""
showFullContent = false
readingTime = false
hideComments = false
color = "" #color from the theme settings
+++

One of the goals I set for my self this year 
was to learn rust so that I could build apps with [Tauri](https://tauri.app/).

So I am working my way thrue the rust book when i encounter something very funny.

{{< figure src="/img/cd_glitch.png" 
   alt="" position="center" 
   style="border-radius: 0px;" 
   caption="I use linux btw" 
   captionPosition="center" 
   captionStyle="color: black;" >}}

How is that possible? It appears that I went into the **showcase** directory
then went back to parent directory but change into what appears like a totally random directory???

## First step

The first step when trying to figure why something 
went wrong in software is to try to replicate it.

From what I remembered all that I did up to that point was 
create a new directory because I was not sure if Cargo the rust package manager,
would reinstall any library installed from a different project.
After that I deleted the folder because it was no longer needed.

Wait, how did I eliminate the folder? 

It all clicked. The issue was I would change directorys using 
vscodes terminal window but create and delete the folder thrue 
the buttons in vscode (i know mkdir exist its just that i happened to have my hand on the mouse at the time). Because I did not delete the folder thrue the terminal i completly forgot that the showcase directory no long exist because it had been deleted, how can you go up to the parent directory on a directory that does not exist?

## What happens when you delete something on a computer?

It appears that when you delete something atleast thrue a GUI that the file does not just dissapear forever, they end up in this directory 

```.local/share/Trash/files```

I enter the list directory command and I fould hundreds of other files and folders that I had deleted weeks prior. Its in the name
/Trash/files/. This appears to be some sort of trashcan. Knowing this I try to replicate it and it does the exact same thing, noting that it only works when deleting thrue the gui but not thrue "rm -rf".

This is when I ask chatgpt and it points me to 
[freedesktop.org](https://www.freedesktop.org) and 
the [trash specification](https://specifications.freedesktop.org/trash-spec/trashspec-latest.html). This little 10 minute 
side tangent from learning rust was fun.

ok bai.