#include <Rdefines.h>
#include <Rinternals.h>

/* Remove a variable that is known to exist in an environment */
void remove_by_name(SEXP name_, SEXP rho) {
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

SEXP recycle_by_name(SEXP name_, SEXP rho) {
  SEXP var;
  const char *name;
  int named;

  name = CHAR(asChar(name_));
  var = findVar(install(name), rho);
  named = NAMED(var);

  /* Remove the variable used to reference the object */
  remove_by_name(name_, rho);

  /* Can we recycle? */
  if (named == 1) SET_NAMED(var, 0);

  /*  Rprintf("NAMED(%s)=%d\n", name, NAMED(var)); */

  return var;
}


SEXP string() {
  SEXP var = mkChar("Hello world!");
  Rprintf("NAMED: %d\n", NAMED(var));
  SET_NAMED(var, 0);
  return var;
}
