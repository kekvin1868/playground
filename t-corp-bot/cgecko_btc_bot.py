import requests
import pandas as pd
from datetime import datetime, timedelta

end_date = datetime.now()
start_date = end_date - timedelta(days=200)

end_timestamp = int(end_date.timestamp())
start_timestamp = int(start_date.timestamp())

# Coin Gecko API
url = f'https://api.coingecko.com/api/v3/coins/bitcoin/market_chart/range?vs_currency=usd&from={start_timestamp}&to={end_timestamp}'

# Fetch data
res = requests.get(url)
data = res.json()

# Ext. prices
prices_data = data['prices']

df = pd.DataFrame(prices_data, columns=['timestamp', 'prices'])
df['date'] = pd.to_datetime(df['timestamp'], unit='ms')
df.set_index('date', inplace=True)
df.drop(columns=['timestamp'], inplace=True)

print(df.head())