"""
    gradient descent method

"""

import numpy as np


def main():

    x = np.random.rand(100)     # creat 100 numbers from 0 to 1.
    y = 10 + 5 * x              # creat a linear function

    print(len(x), len(y))
    epsilon = 0.01   # set threshold to stop loop

    cnt = 0
    alpha = 0.001   # set the step size of gradient update
    theta0 = 0      # x0=1, according to theta0
    theta1 = 0      # x1=xi

    error1 = 0
    error0 = 0

    while True:
        sum0 = 0
        sum1 = 0
        cnt = cnt + 1
        for i in range(0, len(x)):     # BGD method
            diff = y[i] - (theta0 + theta1 * x[i])  # gradient function

            sum0 = sum0 + diff          # theta0 derivative
            sum1 = sum1 + diff*x[i]     # theta1 derivative

        theta0 = theta0 + alpha * sum0/len(x)   # gradient update
        theta1 = theta1 + alpha * sum1/len(x)   # gradient update

        error1 = 0
        for i in range(0, len(x)):
            error1 = error1 + (y[i] - (theta0 + theta1 * x[i]))**2  # loss function

        if abs(error1) < epsilon:   # get a whole minimum numer
            print('error1-0:', abs(error1))
            break
        # if abs(error1-error0) < epsilon:   # get a relative minimum numer
        #     print('error1-0:', abs(error1))
        #     break

        else:
            error0 = error1     # get a relative minimum number
            print('error1:', error1)

        print('theta0:', theta0, 'theta1:', theta1)


if __name__ == '__main__':
    main()
