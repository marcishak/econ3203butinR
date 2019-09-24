#! /bin/bash

## updates R notebook files into github pages site.

for folder in  $(ls -d */) 
do
    # echo $folder
    if [ $folder == "docs/" ]
    then
        continue
    fi
    for file in $(ls $folder*nb.html)
    do
        if [ ! -d "docs/${folder: : -1}" ]
        then
            `mkdir "docs/${folder: : -1}"`
        else
            echo "${folder: : -1}"
        fi
        `cp $file docs/"$folder"index.html`
    done
done

`cp index.html docs/index.html` 