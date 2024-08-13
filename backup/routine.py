import schedule
import time
import os

def backup():
    os.system('/root/backup2.sh')
    print("backup executado")

schedule.every().day.at("23:59").do(backup)

while True:
    schedule.run_pending()
    time.sleep(60)
