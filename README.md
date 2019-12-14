# Discuss

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix

## Comments

DiscussWeb.PageView.render("index.html")
mix phx.gen.schema User users name:string email:string bio:string number_of_pets:integer
mix phx.server
mix phx.routes
mix ecto.gen.migration add_topics
mix ecto.migrate

import - Take all the functions out of importing module and give them to importer module. Copies all functions.
alias - Give me a shortcut to this other module, my fingers are lazy. Makes references for internal module calls.
use - I want to do some really, really... really fancy setup

use DiscussWeb, :controller - import all actions from function in DiscussWeb
%Plug.Conn{} - struct
struct=%DiscussWeb.Topic{}
params=%{title: "Great JS"}
DiscussWeb.Topic.changeset(struct, params)
conn|>halt() - stops rendering of page
plug DiscussWeb.Plugs.RequireAuth when action in [:new, :create, :edit,:update, :delete] - runs plugs only when needed