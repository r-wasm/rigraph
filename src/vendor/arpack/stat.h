c     %--------------------------------%
c     | See stat.doc for documentation |
c     %--------------------------------%
c
c\SCCS Information: @(#) 
c FILE: stat.h   SID: 2.2   DATE OF SID: 11/16/95   RELEASE: 2 
c
      real       t0, t1, t2, t3, t4, t5
c     save       t0, t1, t2, t3, t4, t5
c
      integer    nopx, nbx, nrorth, nitref, nrstrt
      real       tsaupd, tsaup2, tsaitr, tseigt, tsgets, tsapps, tsconv,
     &           tnaupd, tnaup2, tnaitr, tneigh, tngets, tnapps, tnconv,
     &           tcaupd, tcaup2, tcaitr, tceigh, tcgets, tcapps, tcconv,
     &           tmvopx, tmvbx, tgetv0, titref, trvec
c      common /timing/ 
c     &           nopx, nbx, nrorth, nitref, nrstrt,
c     &           tsaupd, tsaup2, tsaitr, tseigt, tsgets, tsapps, tsconv,
c     &           tnaupd, tnaup2, tnaitr, tneigh, tngets, tnapps, tnconv,
c     &           tcaupd, tcaup2, tcaitr, tceigh, tcgets, tcapps, tcconv,
c     &           tmvopx, tmvbx, tgetv0, titref, trvec
