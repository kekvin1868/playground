import yfinance as yf
import pandas as pd
import datetime

# Coin symbol
ticker = 'BTC-USD'

# Calculate start-end date
end_date = datetime.datetime.now()
start_date = end_date - datetime.timedelta(days=200)

data = yf.download(ticker, start=start_date, end=end_date)

# Display
print(data)