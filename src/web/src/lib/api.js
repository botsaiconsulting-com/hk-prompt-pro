export async function getMonthlySales(company, from, to, fetchImpl = fetch) {
  const response = await fetchImpl(`/api/orders/${company}/monthly-sales?from=${from}&to=${to}`);
  if (!response.ok) {
    throw new Error(`Monthly sales request failed (${response.status})`);
  }
  return response.json();
}
