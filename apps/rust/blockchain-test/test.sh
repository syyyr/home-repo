echo -n Testing seq:
time ./blockchain < input > /dev/null
echo -n Testing par:
time ./blockchain-par < input > /dev/null
