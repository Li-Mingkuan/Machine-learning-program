"""
    gradient descent method with matrix

"""

import numpy as np
from numpy import *


def main():
    #
    # x = np.random.rand(100)   # create 100 numbers from 0 to 1.
    # y = 10 + 5 * x              # create a linear function

    theta0 = np.mat([np.ones(100)])
    x = np.mat([np.random.rand(100)])
    x_ex = mat(np.array((theta0, x)))
    y_m = mat((10+5*x))
    theta = (mat([0,0])).T

    epsilon = 0.001   # set threshold to stop loop

    cnt = 0
    alpha = 0.01   # set the step size of gradient update
    loss0 = 0
    while True:
        cnt = cnt + 1
        diff = x_ex*(theta.T*x_ex-y_m).T
        theta = theta - alpha*diff/len(x)

        loss1 = (theta.T*x_ex-y_m)*(theta.T*x_ex-y_m).T/(1/(2*len(x)))
        if (abs(loss1-loss0)<epsilon):
            print("loss1:",loss1)
            print("theta:",theta)
            break
        else:
            loss0 = loss1
            print("loss0:", loss0)
            print("theta:", theta)
    print("cnt:",cnt)


if __name__ == '__main__':
    main()

