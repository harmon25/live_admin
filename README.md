<!-- This README was generated with docout (https://github.com/tfwright/docout). Edits should be made to the formatter instead of this file, other changes will be overridden on compile. -->

# LiveAdmin

[![hex package](https://img.shields.io/hexpm/v/live_admin.svg)](https://hex.pm/packages/live_admin)
[![CI status](https://github.com/tfwright/live_admin/workflows/CI/badge.svg)](https://github.com/tfwright/live_admin/actions)

An admin UI for Phoenix applications built on [Phoenix LiveView](https://github.com/phoenixframework/phoenix_live_view) and [Ecto](https://github.com/elixir-ecto/ecto/).

Significant features:

* First class support for multi tenant applications via Ecto's `prefix` option
* Overridable views and API
* Easily add custom actions at the schema and record level
* Ability to edit (nested) embedded schemas

## Installation

First, ensure your Phoenix app has been configured to use [LiveView](https://hexdocs.pm/phoenix_live_view/installation.html).

Add to your app's `deps`:

```
{:live_admin, "~> 0.8.2"}
```

Add the following to your Phoenix router in any scope ready to serve a live route:

```
import LiveAdmin.Router
# ...
live_admin "/admin" do
  admin_resource "/my_schemas", MyApp.SomeEctoSchema
end
```

The module passed as the second argument to `admin_resource` must `use LiveAdmin.Resource`.
If the module is an Ecto schema, no configuration is required, and LiveAdmin will use the module in all queries.
If the module is not an Ecto schema, you must identify the schema that should be used:

```
defmodule MyApp.SomeResource do
  use LiveAdmin.Resource, schema: MyApp.SomeEctoSchema
end
```

To customize the behavior for that resource, the following options may also be used:

* `title_with` - a binary, or MFA that returns a binary, used to identify the resource
* `label_with` - a binary, or MFA that returns a binary, used to identify individual records
* `list_with` - an atom or MFA that identifies the function that implements listing a resource
* `create_with` - an atom or MFA that identifies the function that implements creating a resource
* `update_with` - an atom or MFA that identifies the function that implements updating a record
* `delete_with` - an atom or MFA that identifies the function that implements deleting a record
* `validate_with` - an atom or MFA that identifies the function that implements validating a changed record
* `render_with` - an atom or MFA that identifies the function that implements table field rendering logic
* `hidden_fields` - a list of fields that should not be displayed in the UI
* `immutable_fields` - a list of fields that should not be editable in forms
* `actions` - list of atoms or MFAs that identify a function that operates on a record
* `tasks` - list atoms or MFAs that identify a function that operates on a resource
* `components` - keyword list of component module overrides for specific views (`:list`, `:new`, `:edit`, `:home`, `:nav`, `:session`)

## App config

The following runtime config is supported:

* `ecto_repo` - the Ecto repo to use for db operations
* `prefix_options` - a list or MFA specifying `prefix` options to be passed to Ecto functions
* `css_overrides` - a binary or MFA that returns CSS to be appended to app css
* `session_store` - a module implementing the [LiveAdmin.Session.Store](/lib/live_admin/session/store.ex) behavior, used to persist session data

In addition to these, most resource configuration can be set here in order to set a global default to apply to all resources unless overridden in their individual config.

Example:

```
config :live_admin,
  ecto_repo: MyApp.Repo,
  prefix_options: {MyApp.Accounts, :list_tenant_prefixes, []},
  immutable_fields: [:id, :inserted_at, :updated_at],
  label_with: :name
```

See [development app](/dev.exs) for more example configuration.

## Development environment

This repo has been configured to run the application in Docker. Simply run `docker compose up` and navigate to http://localhost:4000

The Phoenix app is running the `app` service, so all mix command should be run there. Examples:

* `docker compose run web mix test`

---

README generated with [docout](https://github.com/tfwright/docout)
