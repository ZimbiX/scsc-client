scsc-client
===========

A simple Ruby client for the Swinburne Cyber Security Club chat server

## Setup

Install Ruby 2.0.0 using RVM:

    \curl -L https://get.rvm.io | bash -s stable --ruby

If you want to run the chat server yourself, download the [SCSC chat server], set up a password, and run it:

    git clone git@github.com:rlgod/scsc_sprint1.git
    cd scsc_sprint1
    echo "password" > bin/key.txt
    bin/scschat

Obviously, download this client:

    git clone git@github.com/ZimbiX/scsc-client.git
    cd scsc-client

## Usage

Run the chat client (you can use a colon or a space between the IP and port:

    ./chat_client.rb <ip>:<port>

The server runs on port 9034 by default.

So to connect to your local server:

    ./chat_client.rb localhost:9034

Or to connect to the main SCSC server:

    ./chat_client.rb 54.254.172.116:9034

When prompted, enter the password. The password for the main SCSC server is:

> BRAINS_ARE_PRETTY_NEAT