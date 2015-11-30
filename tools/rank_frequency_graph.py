#!/usr/bin/env python
# coding=UTF-8

import argparse
import matplotlib.pyplot as plt


def str2bool(v):
    return v.lower() in ("yes", "true", "t", "1")


if __name__ == "__main__":
    ##########################################################################
    # args
    parser = argparse.ArgumentParser(description='PLots line graphs from CSV file')
    parser.register('type', 'bool', str2bool)
    parser.add_argument('-i', metavar='INPUT_FILE', type=str, required=True, help='CSV input file name')
    parser.add_argument('-o', metavar='OUTPUT_FILE_NAME', type=str, required=False, default='results', help='Output file name (exports in svg, eps and pdf)')
    parser.add_argument('-x', metavar='FILE_COLUMN', type=int, required=False, default=1, help='CSV data column with the x data for each file split by -')
    parser.add_argument('-z', metavar='FILE_VALUE_DELIMITER', type=str, required=False, default="\t", help='Value delimiter in each line')
    parser.add_argument('-e', metavar='FILE_N_SKIP_ROWS', type=int, required=False, default=0, help='Number of rows to skip when reading files')
    parser.add_argument('-t', metavar='GRAPH_TITLE', type=str, required=False, default='', help='Graph title')
    parser.add_argument('-b', metavar='X_AXIS_LABEL', type=str, required=False, default='log10 rank', help='X axis label')
    parser.add_argument('-v', metavar='Y_AXIS_LABEL', type=str, required=False, default='log10 frequency', help='Y axis label')
    parser.add_argument('-g', metavar='DISPLAY_GRID', type='bool', required=False, default=True, help='Show graph grid')
    parser.add_argument('-s', metavar='SAVE_GRAPH', type='bool', required=False, default=True, help='Save graphs to files using the name prefix specified with -o')
    parser.add_argument('-d', metavar='DISPLAY_GRAPH', type='bool', required=False, default=False, help='Show graph')
    args = parser.parse_args()


    ##########################################################################
    # graph setup
    fig, ax = plt.subplots(figsize=(19.2, 10.8), dpi=100)

    plt.xlabel(args.b)
    plt.ylabel(args.v)
    graph_title = plt.title(args.t, fontsize=16)
    graph_title.set_y(1.01)

    plt.minorticks_on()
    if args.g:
        plt.grid(b=True, which='major', color='k', linestyle='--', linewidth=0.30, alpha=0.5)
        plt.grid(b=True, which='minor', color='k', linestyle=':', linewidth=0.01, alpha=0.2)


    ##########################################################################
    # graph plotting
    freqs = []
    for line in open(args.i):
        columns = line.split(args.z)
        if len(columns) > args.x:
            freqs.append(int(columns[args.x].strip()))

    ranks = range(1, len(freqs) + 1)
    ax.loglog(ranks, freqs)
    plt.axis('scaled')
    plt.draw()


    ##########################################################################
    # output
    if args.s:
        plt.savefig('%s.pdf' % args.o, bbox_inches='tight')
        plt.savefig('%s.png' % args.o, dpi=300, bbox_inches='tight')


    if args.d:
        plt.show()

    exit(0)
