Puppet Completion
=================

Puppet code and bash completion script to allow bash command line completion

Requirements
============

Puppet 2.7.x or greater

Installation
============

The easiest way to use this is to run it from source by modifying your RUBYLIB.

    RUBYLIB=/path/to/puppet-completion/lib:$RUBYLIB

Add the following to your .bashrc (don't forget to change the path to be
correct):

    complete -C /path/to/your/bash/completion/puppet-completion.rb -o default puppet

Tab completion of puppet should now work in bash.

Long term this is something that is planned to be merged into core Puppet, but for now it's separate so that people can test it out and improve on it quickly.
