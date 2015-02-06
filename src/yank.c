#include <Rdefines.h>
#include <Rinternals.h>

SEXP yank(SEXP name_, SEXP rho) {
  const char *name;

  name = CHAR(asChar(name_));
  Rprintf("Variable name: '%s'\n", name);

  setVar(name_, R_UnboundValue, rho);
  return R_NilValue;
}

/*
[Rd] How does R_UnboundValue and removing variables work?, Aug 2013
https://stat.ethz.ch/pipermail/r-devel/2013-August/067148.html
*/
