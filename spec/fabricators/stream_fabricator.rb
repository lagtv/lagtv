Fabricator(:stream) do
  name "maximusblack"
  live false
  username "lagtvmaximusblack"
  provider "twitch"
end

Fabricator(:maximusblack_stream, from: :stream) do
  name "maximusblack"
  live false
end

Fabricator(:novawar_stream, from: :stream) do
  name "novawar"
  username "novawar"
  live false
end

Fabricator(:lagtv_stream, from: :stream) do
  name "lagtv"
  username "lifesaglitchtv"
  live false
end
