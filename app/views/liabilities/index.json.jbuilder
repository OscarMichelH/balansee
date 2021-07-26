json.array! @liabilities, partial: "liabilities/liability", as: :liability

json.assets do
  json.array! @liabilities
end
json.total do
  json.name 'Total Liabilities'
  json.value @total_debt
  json.income @total_payment
end
