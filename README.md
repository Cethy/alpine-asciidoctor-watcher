# Alpine Asciidoctor Watcher

Asciidoctor Watcher docker image based on Alpine.

Run a basic ruby [Guard](https://github.com/guard/guard) app which will run Asciidoctor 
when a modification in your files (`*.asc`|`*.md`) is detected. 

## How to use
By default the script looks for a `index.asc` file in the source directory and build `html sources` from it 
when modifications are detected (Guard will only watch `asc` & `md` files).

### Minimal configuration
The watcher needs to have 2 volumes :
- the source directory
- the output directory


    docker run -ti \
        -v <host source directory>:/documents/ \
        -v <host output directory>:/output/ \
        cethy/alpine-asciidoctor-watcher:micro

**notes** 
- the host directories can be the same (and must be absolute) ;
- `-ti` is needed to be able to quit guard with `ctrl+c`.

Example usage with a local directory :

    docker run -ti \ 
        -v $PWD/doc:/documents/ \
        -v $PWD/doc:/output/ \
        cethy/alpine-asciidoctor-watcher:micro

### Format configuration
To output other format than html, just override the `OUTPUT_FORMATS` variable :

    docker run -ti \
        -v <host source directory>:/documents/ \
        -v <host output directory>:/output/ \
        -e OUTPUT_FORMATS="html,epub3"
        cethy/alpine-asciidoctor-watcher:mini

This particular example will output `html` AND `epub3` files.


### Full configuration

#### default configuration

    docker run -ti \
        -v <host source directory>:/documents/ \
        -v <host output directory>:/output/ \
        -e OUTPUT_FORMATS="html" \
        -e OUTPUT_DIR='/output' \
        -e INPUT_FILE='index.asc' \
        -e INPUT_DIR='/documents' \
        -e INPUT_EXTRA_PARAMETERS='' \
        cethy/alpine-asciidoctor-watcher:<micro|mini|full>

#### Options
##### `OUTPUT_FORMATS`

		# default
        -e OUTPUT_FORMATS="html"
        # example full
        -e OUTPUT_FORMATS="html,pdf,epub3"

List the output format files, separated by a `,` comma.

**Note** : the `micro` image does **not** contains this variable.

|Default|Options|
|:---:|---|
|`html`|`html`, `pdf` and/or `epub3`|


##### `OUTPUT_DIR`

	# default
	-e OUTPUT_DIR='/output'
	
Represents the container output directory.

|Default|Options|
|:---:|---|
|`/output`|\<any container directory\>|


##### `INPUT_FILE`

	# default
	-e INPUT_FILE='index.asc'

Represents the input file given to `Asciidoctor`.

|Default|Options|
|:---:|---|
|`index.asc`|\<any file name\>|


##### `INPUT_DIR`
		
	# default
	-e INPUT_DIR='/documents'

Represents the input directory where live the `INPUT_FILE`.

|Default|Options|
|:---:|---|
|`/documents`|\<any container directory\>|

##### `INPUT_EXTRA_PARAMETERS`
		
	# default
	-e INPUT_EXTRA_PARAMETERS=''

Represents the extra parameters you want to send to `Asciidoctor`.

|Default|Options|
|:---:|---|
|-|\<any acceptable `Asciidoctor`\>|


## Image Variants

### `alpine-asciidoctor-watcher`

This variant is the default and contains the full functionality from the official Asciidoctor image (except fopub at the moment). Ideal if you need the full-fledged Asciidoctor in all its glory.

* Asciidoctor
* Aciidoctor Diagram with Graphviz integration so you can use plantuml and graphiz diagrams
* Asciidoctor PDF (alpha)
* Asciidoctor EPUB3 (alpha)
* Source highlighting using CodeRay or Pygments
* Asciidoctor backends
* Asciidoctor-confluence
* Lazybones (for Asciidoctor-revealjs)

### `alpine-asciidoctor-watcher:mini`

This variant is a trimmed down version with basic support for diagrams, support for PDF and EPUB3 formats and confluence. Ideal if you need to export to several formats or make basic diagrams.

* Asciidoctor
* Aciidoctor Diagram
* Asciidoctor PDF (alpha)
* Asciidoctor EPUB3 (alpha)
* Source highlighting using CodeRay
* Asciidoctor-confluence


### `alpine-asciidoctor-watcher:micro`

This variant is a trimmed down version containing only the necessary to build basic asciidoc files with source highlighting. Ideal for building simple documentation to HTML.

- Asciidoctor
- Source highlighting using CodeRay

**Note** : Support only `html`output.


## Misc

### Base images
[cethy/alpine-asciidoctor-builder](https://github.com/Cethy/alpine-asciidoctor-builder)
[rochdev/docker-alpine-asciidoctor](https://github.com/rochdev/docker-alpine-asciidoctor)

### Related work
- asciidoctor builder docker image [cethy/alpine-asciidoctor-builder](https://github.com/Cethy/alpine-asciidoctor-builder) 
([on docker hub](https://hub.docker.com/r/cethy/alpine-asciidoctor-builder/))
- WIP asciidoctor livereload environment [cethy/asciidoctor-livereload]()

## Todo
- unduplicate `app/` & `entrypoint.sh` (app builder image ?)
