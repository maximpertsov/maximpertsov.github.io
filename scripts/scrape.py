import argparse


def run(path):
    with open(path) as f:
        for i, line in enumerate(f):
            for cell in line.split("\t")[2:]:
                print(cell)

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Parse Sin of Mana data")
    parser.add_argument("filepath", type=str, help="data filepath")

    args = parser.parse_args()

    run(args.filepath)
