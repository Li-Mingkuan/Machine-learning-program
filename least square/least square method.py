"""
    least square method

"""
import numpy as np


def main():

    x = np.random.rand(100)
    y = 10 + 5 * x
    sum1 = 0
    sum2_x = 0
    sum2_y = 0
    sum3 = 0

    for i in range(0, len(x)):
        sum1 = sum1 + x[i]*y[i]
        sum2_x = sum2_x + x[i]
        sum2_y = sum2_y + y[i]
        sum3 = sum3 + x[i]*x[i]

    a = (len(x)*sum1) - (sum2_x*sum2_y)
    b = (len(x)*sum3) - (sum2_x*sum2_x)

    theta1 = a/b
    theta0 = (sum2_y/len(x))-theta1*(sum2_x/len(x))

    print('y = {} + {}*x'.format(theta0, theta1))


if __name__ == '__main__':
    main()
