"""
    gradient steepest descent method
"""

import numpy as np
from numpy import *


def main():

    n = 100
    theta0 = np.mat([np.ones(n)])
    x = np.mat([np.random.rand(n)])
    x_ex = mat(np.array((theta0, x)))
    y_m = mat((10+5*x))
    theta = (mat([0,0])).T
    Q = (x_ex*x_ex.T)/n
    b = (x_ex*y_m.T)/n

    epsilon = 0.001   # set threshold to stop loop

    cnt = 0
    loss0 = 0

    while True:
        cnt = cnt + 1
        diff = Q*theta - b
        theta = theta - float((diff.T*diff)/(diff.T*Q*diff))*diff
        loss1 = (theta.T * x_ex - y_m) * (theta.T * x_ex - y_m).T / (1 / (2 * len(x)))
        if (abs(loss1 - loss0) < epsilon):
            print("loss1:", loss1)
            print("theta:", theta)
            break
        else:
            loss0 = loss1
            print("loss0:", loss0)
            print("theta:", theta)
    print("cnt:", cnt)


if __name__ == '__main__':
    main()

