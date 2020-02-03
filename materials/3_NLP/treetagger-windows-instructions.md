---
layout: default
---

![CAD-logo](assets/img/CAD-logo-long.png)

# Codificare, Analizzare, Diffondere: <br />Le *Digital Humanities* nei progetti di ricerca
<br/>
&#11025; [Torna alla Homepage](index.md)
<br/>

## How to install the Windows version of TreeTagger                     

The Windows distribution of TreeTagger contains the following files:

- `tree-tagger.exe`: the tagger program
- `train-tree-tagger.exe`: the training program
- `utf8-tokenize.perl`: a Perl script which transforms the tagger input
into one-word-perl-line format
- `*-abbreviations`: abbreviation lists required by the tokenizer
- `tag-*.bat`: batch files for different languages which call the tokeniser and the tagger 
- `chunk-*.bat`: batch files for POS tagging and chunking


### Perl Interpreter

First of all, you need to download and install a Perl interpreter (if you have not already installed one). You can download a Perl interpreter for Windows for free at: <a href="http://strawberryperl.com" target="_blank" title="Opens in new tab">http://strawberryperl.com</a>

### TreeTagger downloads

1. Download these TreeTagger files from the [official TreeTagger website](https://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger/):

![alt text](img/treetagger-files.png "TreeTagger files to download")

`Windows64` or `Windows32` zip file according to your computer's processor. The downloaded file will look something like this: `tree-tagger-windows-3.2.2.zip`


![alt text](img/windows-download.png "Windows section of TreeTagger's website")


2. Extract the zip file, rename the resulting folder to `TreeTagger` and **move this folder to the root directory of drive `C:`**.
3. Download the tagging scripts: `tagger-scripts.tar.gz`
4. Download the script `install-tagger.sh`
5. Download the parameter files (trained models) for the languages you need. Unzip them (e.g. using Winzip or 7zip) and move the resulting `.par` file to the `lib` subfolder of the `TreeTagger` folder.


If the files have been unpacked into a single directory, you should
restore the following directory structure:

TreeTagger:

```
INSTALL.txt
README.txt
bin 
cmd
lib
```

TreeTagger/bin:

```
tag-english.bat
tag-german.bat 
tag-spanish.bat        
tag-french.bat    
tag-italian.bat
train-tree-tagger.exe
tree-tagger.exe
```

TreeTagger/cmd:

```
mwl-lookup.perl
tokenize.pl
```

TreeTagger/lib:

```
english-abbreviations 
german-abbreviations   
spanish-abbreviations
french-abbreviations   
italian-abbreviations 
spanish-mwls  
*language*.par
```


### Run TreeTagger

TreeTagger is not a programme you install but must be launched from the Command Line. So, open the Command Prompt (Click on the Windows Start button search for 'Command Prompt'). You should see this:

![alt text](img/terminal.png "Command Prompt window")

1. Navigate to the **C:** drive with the `cd` command: `cd c:`
2. Next, type: `PATH=C:\TreeTagger\bin;%PATH%`
3. Next, navigate to the `TreeTagger` folder: cd `TreeTagger`. Your present working directory should now be: `c:\TreeTagger`
4. Now you can test the tagger on the `INSTALL.txt` file contained in the `TreeTagger` folder: 
   `tag-english INSTALL.txt`
5. Press `ENTER` and you should now see the tagger in action. If you wish to save the results to a file, type `tag-english INSTALL.txt > results.txt` and the tagged texts will appear in your `TreeTagger folder`.


### Troubleshooting

1. If you install the TreeTagger in a different directory (so not in the C: drive), you have to modify the first path in the batch files `tag-*.bat` using an editor such as Wordpad or Sublime Text Editor.

2. Should you get a "No such file or directory" error from TreeTagger, it's possible that the `.bat` and `.par` files for the language you're analysing aren't linked to one another in your TreeTagger `bin` and `lib` folders. To link the two files, make sure that the `PARFILE` field in the `bat` file contains the correct language `par` file. The code below is the TreeTagger italian `bat` file, which should be linked to the `italian.par` file for TreeTagger to work (see the `PARFILE=${LIB}/italian.par` field).

```
#!/bin/sh

# Set these paths appropriately

BIN="/Users/greta/Desktop/treetagger/bin"
CMD="/Users/greta/Desktop/treetagger/cmd"
LIB="/Users/greta/Desktop/treetagger/lib"

OPTIONS="-token -lemma -sgml"

TOKENIZER=${CMD}/utf8-tokenize.perl
TAGGER=${BIN}/tree-tagger
ABBR_LIST=${LIB}/italian-abbreviations
PARFILE=${LIB}/italian.par

$TOKENIZER -i -a $ABBR_LIST $* |
$TAGGER $OPTIONS $PARFILE
```