#!/bin/sh
git status --porcelain | \
    awk 'BEGIN {FS=" "}
{
    xstat = substr($0, 1, 1);
    ystat = substr($0, 2, 1);
    f = substr($0, 4);
    ri = index(f, " -> ");
    if (ri > 0) f = substr(f, 1, ri);
    if (xstat == " " && ystat ~ "M|D") stat = "not updated";
    else if (xstat == "M" && ystat ~ " |M|D") stat = "updated in index";
    else if (xstat == "A" && ystat ~ " |M|D") stat = "added to index";
    else if (xstat == "D" && ystat ~ " |M") stat = "deleted from index";
    else if (xstat == "R" && ystat ~ " |M|D") stat = "renamed in index";
    else if (xstat == "C" && ystat ~ " |M|D") stat = "copied in index";
    else if (xstat ~ "M|A|R|C" && ystat == " ") stat = "index and work tree matches";
    else if (xstat ~ " |M|A|R|C" && ystat == "M") stat = "work tree changed since index";
    else if (xstat ~ " |M|A|R|C" && ystat == "D") stat = "deleted in work tree";
    else if (xstat == "D" && ystat == "D") stat = "unmerged, both deleted";
    else if (xstat == "A" && ystat == "U") stat = "unmerged, added by us";
    else if (xstat == "U" && ystat == "D") stat = "unmerged, deleted by them";
    else if (xstat == "U" && ystat == "A") stat = "unmerged, added by them";
    else if (xstat == "D" && ystat == "U") stat = "unmerged, deleted by us";
    else if (xstat == "A" && ystat == "A") stat = "unmerged, both added";
    else if (xstat == "U" && ystat == "U") stat = "unmerged, both modified";
    else if (xstat == "?" && ystat == "?") stat = "untracked";
    else if (xstat == "!" && ystat == "!") stat = "ignored";
    else stat = "unknown status";
    print f "   " stat;
}' | \
    column -t -s "  "
