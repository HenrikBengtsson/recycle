#include <Rdefines.h>
#include <Rinternals.h>

/* Remove a variable that is known to exist in an environment */
void erase(SEXP name_, SEXP rho) {
  /* Call rm(list="<var>", envir=<rho>, inherits=FALSE) */
  SEXP expr = R_NilValue, t;
  t = expr = PROTECT(allocList(4));
  SET_TYPEOF(expr, LANGSXP);
  SETCAR(t, install("rm")); t = CDR(t);
  SETCAR(t, name_); SET_TAG(t, install("list")); t = CDR(t);
  SETCAR(t, rho); SET_TAG(t, install("envir")); t = CDR(t);
  SETCAR(t, ScalarLogical(FALSE)); SET_TAG(t, install("inherits"));
  eval(expr, rho);
  UNPROTECT(1);
}
