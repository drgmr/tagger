defmodule Tagger.Factory do
  @moduledoc false

  use ExMachina.Ecto,
    repo: Tagger.Repo

  alias Tagger.SourceControl.Repository

  def repository_factory do
    %Repository{
      id: Ecto.UUID.generate(),
      name: sequence(:repository, &"Repository #{&1}"),
      languages: [
        sequence(:language, &"Language #{&1}"),
        sequence(:language, &"Language #{&1}")
      ],
      description: sequence(:description, &"Description #{&1}"),
      url: sequence(:url, &"https://github.com/some_user/repo_#{&1}")
    }
  end
end
