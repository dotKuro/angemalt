# angemalt

A tool for injecting the same color scheme into all of your config files.

⚠️ This program is currently really early in development. ⚠️

## What is planned? 

This program, once finished, will allow you to write config templates, which are just your ordinary config files
but with special syntax for injecting colors in different formats. It is planned that you can just drop a file called
`some-random-name.colortemplate.some-extension` anywhere in your home directory and then angemalt will scan your home
directory for these files and will inject the same color scheme into all of this files and will save them next to them
with the name `some-random-name.some-extension`. The theme will be a json file, mapping arbitrary names to color codes.
angemalt will provide access to different color formats and even allows you to access the channels of the color directly
to built your own formats if the one you need is not supported by angemalt.

## What is currently possible?

Currently the templating and injecting mechanism is completely implemented. So it is possible to write template files
and inject a color scheme into them. But all the stuff that actually makes angemalt useable, like scanning you configs
for templates is missing.

You can test the current capabilities of angemalt by cloning this repo and running:
```sh
stack run -- --theme example/theme.json --input example/example.template --output example/example.output
```

Then take a look at the example.template and the example.output files and even play a little with the syntax in the template file. :)

Im currently not satisfied with the syntax of the template file, which is limited by the capabilities of the [template](https://hackage.haskell.org/package/template-0.2.0.10) library, which is used internally to parse the templates. I will probably write an own
parser in the future to improve the syntax.

## What is missing?

This repository is currently missing any tests or documentation.

Yes, im a lazy developer and just wanted to smash some Haskell into my Editor. This will change soon, I promise!

## What can you do, if you want to help with this project?

Even though this is just a project to practice some Haskell for me, I plan on using angemalt for my own configs in the future, because
this is actually a program I wanted to have for a long time. So you might have too? Therefore it is open source so you can use it as well, at least once it is useable. But in the mean time you can read the code and send me some angry messages about how bad my haskell
code is, because it probably is. Jokes aside: Any feedback either about the actual usability of angemalt or about the code and best practices in haskell are appreciated. :)