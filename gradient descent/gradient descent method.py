"""
    gradient descent method

"""

import numpy as np


def main():

    x = np.random.rand(100)
    y = 10 + 5 * x

    print(len(x), len(y))
    epsilon = 0.01   # iterative threshold

    cnt = 0
    alpha = 0.001
    theta0 = 0
    theta1 = 0

    error1 = 0
    error0 = 0

    while True:
        sum0 = 0
        sum1 = 0
        cnt = cnt + 1
        for i in range(0, len(x)):
            diff = y[i] - (theta0 + theta1 * x[i])

            sum0 = sum0 + diff
            sum1 = sum1 + diff*x[i]

        theta0 = theta0 + alpha * sum0/len(x)
        theta1 = theta1 + alpha * sum1/len(x)

        error1 = 0
        for i in range(0, len(x)):
            error1 = error1 + (y[i] - (theta0 + theta1 * x[i]))**2

        if abs(error1) < epsilon:
            print('error1-0:', abs(error1))
            break

        else:
            error0 = error1
            print('error1:', error1)

        print('theta0:', theta0, 'theta1:', theta1)


if __name__ == '__main__':
    main()
