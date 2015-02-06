#include <Rdefines.h>
#include <Rinternals.h>
#include "erase.h"

SEXP recycle_by_name(SEXP name_, SEXP rho) {
  SEXP var;
  const char *name;
  int named;

  name = CHAR(asChar(name_));
  var = findVar(install(name), rho);
  named = NAMED(var);

  /* Remove the variable used to reference the object */
  erase(name_, rho);

  /* Can we recycle? */
  if (named == 1) SET_NAMED(var, 0);

  /*  Rprintf("NAMED(%s)=%d\n", name, NAMED(var)); */

  return var;
}
