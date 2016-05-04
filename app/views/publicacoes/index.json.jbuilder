json.array!(@publicacoes) do |publicacao|
  json.extract! publicacao, :id, :autor, :titulo, :corpo
  json.url publicacao_url(publicacao, format: :json)
end
