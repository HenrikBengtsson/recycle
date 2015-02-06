#include <Rdefines.h>
#include <Rinternals.h>

/**** How to return the pointer of an SEXP as a string?
void address(SEXP name_, SEXP rho) {
  SEXP var;
  const char *name;
  int named;

  name = CHAR(asChar(name_));
  var = findVar(install(name), rho);

  Rprintf("%lx", (long) &name);
}
****/

SEXP named(SEXP name_, SEXP rho) {
  SEXP var, ans;
  const char *name;
  int named = 0;

  name = CHAR(asChar(name_));
  var = findVar(install(name), rho);
  named = NAMED(var);

  ans = ScalarInteger(named);

  return ans;
}
