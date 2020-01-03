defmodule TaggerWeb do
  @moduledoc """
  The entrypoint for defining our web interface, such
  as controllers, views, channels and so on.

  This can be used as:

      use TaggerWeb, :controller
      use TaggerWeb, :view

  The definitions below will be executed for every view,
  controller, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below. Instead, define any helper function in modules
  and import those modules here.
  """

  def controller do
    quote do
      use Phoenix.Controller, namespace: TaggerWeb

      import Plug.Conn
      import TaggerWeb.Gettext

      use BlueBird.Controller

      alias TaggerWeb.Router.Helpers, as: Routes
    end
  end

  def view do
    quote do
      use Phoenix.View,
        root: "lib/tagger_web/templates",
        namespace: TaggerWeb

      import Phoenix.Controller, only: [get_flash: 1, get_flash: 2, view_module: 1]

      import TaggerWeb.ErrorHelpers
      import TaggerWeb.Gettext

      alias TaggerWeb.Router.Helpers, as: Routes
    end
  end

  def router do
    quote do
      use Phoenix.Router

      import Plug.Conn
      import Phoenix.Controller
    end
  end

  def channel do
    quote do
      use Phoenix.Channel

      import TaggerWeb.Gettext
    end
  end

  @doc """
  When used, adds the appropriate utilities to the module.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
