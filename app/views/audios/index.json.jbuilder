json.array!(@audios) do |audio|
  json.extract! audio, :id
  json.url audio_url(audio, format: :json)
end
