json.assets do
  json.array! @assets
end
json.total do
  json.name 'Total Assets'
  json.value @total_value
  json.income @total_income
end
