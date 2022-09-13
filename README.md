# ezthor - EZ thor...

__(Still under development)__ 


Just a simple YAML to CLI converter for creating a working Command Line Interface based on a simple YAML file.

This project aims to provide a functional skeleton of a Thor CLI written in Ruby. 

## How it works ? 

1. Reads content of `commands.yml`
2. Interpret keys and values
3. Write a new file based on name given in YAML template
4. Your CLI is ready to use !

## Getting started

Install Thor gem : `gem install thor`

Simple getting started...

1. Run `ruby main.rb`
2. Your CLI is ready !
3. Run `ezthor.rb` => See your CLI

## Create your own CLI

The whole configuration of your cli is located at `./commands.yml`

Keys :

* `name` - `String` - Name of your CLI file, your Thor class 
* `description` - `String` - Main description of your CLI
* `options` - `Array` - (Optional) - Contains thor `class_options`
  * `name` - `String` - Name of the flag
  * `type` - `String` - Type of the flag
  * `short` - `String` - Shortcut of the flag (equals to `aliases` in Thor)
* `commands` - List of top-level commands
  * `<Name of the command>`
    * `cmd` - `String` - Main command of your newly created thor command
    * `description` - `String` - Description of your thor command
    * `param` - `Array` (Optional) - Command parameters
      * `name` - `String` (Required) - Name of the parameter
      * `default` - `String | Nil | Boolean` (Optional) - Default value of command parameter
        * If not defined, param becomes a required argument for the command
    * `options` - `String` (Optional) - List of options for your thor command
      * `name` - `String` - Option name
      * `short` - `String` - Shorcut of the option
      * `required` - `Boolean`
      * `desc` - `String` - Description of the option
      * `default` - `String`
