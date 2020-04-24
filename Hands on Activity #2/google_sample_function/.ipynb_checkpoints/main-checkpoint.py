import pandas as pd
from google.oauth2 import service_account


def execute(self):
    
    #Loads credentials from JSON File
    credentials = service_account.Credentials.from_service_account_file(
    'mago-gbq.json')
    
    #Calls the orders table from Big Query
    df = pd.read_gbq(query = 'SELECT * FROM `citric-campaign-274511.brownbag_dataeng.orders` LIMIT 1000', 
                 project_id = '219807261683', 
                 credentials = credentials, 
                 dialect = 'standard')
    
    df['customerNumber'] = df['customerNumber'] + 20
    df['pogi'] = 1
    
    #Saves the table to BQ
    df.to_gbq(destination_table = 'brownbag_dataeng.updated_orders', 
          project_id = '219807261683', 
          if_exists = 'replace',
          credentials = credentials)