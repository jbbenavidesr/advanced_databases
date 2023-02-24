"""Simple script that reads datasets in CSV format and generates SQL INSERT statements 
for them."""

import csv
from pathlib import Path

BASE_PATH = Path(__file__).parent

def main():

    input_path = BASE_PATH / "generated_datasets"
    output_path = BASE_PATH / "generated_sql"

    for file in input_path.glob("*.csv"):
        with open(file, "r") as f:
            reader = csv.DictReader(f)
            table_name = file.stem
            output_file = output_path / f"{table_name}.sql"
            with open(output_file, "w") as out:
                for row in reader:
                    sql = f"INSERT INTO {table_name} VALUES ("
                    for value in row.values():
                        if value == "":
                            sql += "NULL, "
                        else:
                            sql += f"'{value}', "
                    sql = sql[:-2] + ");"
                    out.write(sql  + "\n")                    

if __name__ == "__main__":
    main()