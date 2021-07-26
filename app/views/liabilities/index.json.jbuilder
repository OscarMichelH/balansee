json.liabilities do
  json.array! @liabilities
end
json.total do
  json.name 'Total Liabilities'
  json.debt @total_debt
  json.payment @total_payment
end
