+++
title = "snake_case 🐍"
date = "2023-05-27T23:37:49-06:00"
author = "Jorge"
authorTwitter = "" #do not include @
cover = ""
tags = ["silly", "Lua"]
keywords = ["", ""]
description = "Good old snake case"
showFullContent = false
readingTime = false
hideComments = false
color = "" #color from the theme settings
+++

## 🐍

I know what snake case means but I thought what if snake case ment ending words with `ssss` like a snake LOL

Here below is code snippet from my [github repo](https://github.com/MrBocch/Advent_of_Code_2022_Lua) where I try to solve all of the 2022 Advent of Code problems in Lua 

```Python
function part2()
    local filesss = io.open("input6.txt")
    io.input(filesss)

    local stringsss = io.read("*all")

    for i=14, #stringsss do
        setsss = {}
        setSizesss = 0

        for k= i-13, i do
            if setsss[string.sub(stringsss, k,k)] == nil then
                setsss[string.sub(stringsss, k,k)] = true
                setSizesss = setSizesss + 1
            end
        end
    
        if setSizesss == 14 then
            print("Part 2: "..i)
            return
        end

    end
end
```

Very sillysss.