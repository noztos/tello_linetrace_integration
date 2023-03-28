import argparse
import json
import matplotlib.pyplot as plt
import numpy as np
import sys
from operator import itemgetter
from scipy import interpolate
from scipy.spatial import distance

DIST_THREASHOLD = 1.0

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('-sp', '--spline_points_json')
    parser.add_argument('-fl', '--flight_log_text')
    parser.add_argument('-png', '--result_fig_png')
    args = parser.parse_args()
    
    with open(args.flight_log_text) as f:
        lines = f.readlines()
    rs = [l.rstrip().split(sep='\t') for l in lines[1:]]
    flight_xs = [float(r[2]) for r in rs]
    flight_ys = [float(r[3]) for r in rs]

    with open(args.spline_points_json) as f:
        js = json.load(f)
    spline_points = [js['rope-info']['start-pos']] + js['rope-info']['spline-points']
    spline_points_xs = [float(p[0])/100 for p in spline_points]
    spline_points_ys = [float(p[1])/100 for p in spline_points]
    spline = interpolate.interp1d(spline_points_xs, spline_points_ys, kind="cubic")
    target_xs = np.arange(min(spline_points_xs), max(spline_points_xs), 0.1)
    target_ys = spline(target_xs)

    flight_ps = list(zip(flight_xs, flight_ys))
    target_ps = list(zip(target_xs, target_ys))
    def dist_to_nearest(p, qs):
        return min([distance.euclidean(p, q) for q in qs])
    dists = [dist_to_nearest(p, target_ps) for p in flight_ps]
    off_target_points_index = [i for i, d in enumerate(dists) if d > DIST_THREASHOLD]
    if len(off_target_points_index) > 0:
        off_target_points_xs = itemgetter(*off_target_points_index)(flight_xs)
        off_target_points_ys = itemgetter(*off_target_points_index)(flight_ys)
    else:
        off_target_points_xs = []
        off_target_points_ys = []

    plt.plot(flight_ys, flight_xs, 'o', label='trajectory on target')
    plt.plot(off_target_points_ys, off_target_points_xs, 'o', label='trajectory off target')
    plt.plot(target_ys, target_xs, label='target trajectory')
    plt.legend()
    plt.xlabel('y')
    plt.ylabel('x')
    plt.savefig(args.result_fig_png)
    # plt.show()

    if len(off_target_points_index) == 0:
        return 0
    else:
        return 1

if __name__ == "__main__":
    sys.exit(main())
