from std/strformat import `&`

type
  ExprType* = enum
    E_BINOP
    E_UNARYOP
    E_LIT
    E_VAR
  Expr* = ref object
    line*: int
    col*: int
    case eType*: ExprType
    of E_BINOP:
      binop*: string
      bLhs*: Expr
      bRhs*: Expr
    of E_UNARYOP:
      uOp*: string
      uBody*: Expr
    of E_LIT:
      lVal*: int
    of E_VAR:
      vName*: string
  CondType* = enum
    C_EXPR_PRED
    C_EXPR_REL
  Cond* = ref object
    line*: int
    col*: int
    case cType*: CondType
    of C_EXPR_PRED:
      predName*: string
      pBody*: Expr
    of C_EXPR_REL:
      relOp*: string
      relLhs*: Expr
      relRhs*: Expr
  StatementType* = enum
    S_ASSIGN
    S_CALL
    S_INPUT
    S_PRINT
    S_BLOCK
    S_IF
    S_WHILE
    S_RETURN
  Statement* = ref object
    line*: int
    col*: int
    case sType*: StatementType
    of S_ASSIGN:
      aTarget*: string
      aVal*: Expr
    of S_CALL:
      cTarget*: string
      cArgs*: seq[Expr]
    of S_INPUT:
      iTarget*: string
    of S_PRINT:
      pExpr*: Expr
    of S_BLOCK:
      body*: seq[Statement]
    of S_IF:
      ifCond*: Cond
      ifThen*: Statement
    of S_WHILE:
      wCond*: Cond
      wBody*: Statement
    of S_RETURN:
      rExpr*: Expr
  ProcDef* = ref object
    name*: string
    paramList*: seq[string]
    body*: Block
  Block* = ref object
    line*: int
    col*: int
    constDef*: seq[(string, int)]
    varDef*: seq[string]
    procDef*: seq[ProcDef]
    body*: Statement
  Program* = ref object
    body*: Block
      
proc raiseErrorWithReason*(x: Expr, reason: string): void =
  raise newException(ValueError, &"[Compiler] ({x.line},{x.col}) {reason}")
proc raiseErrorWithReason*(x: Cond, reason: string): void =
  raise newException(ValueError, &"[Compiler] ({x.line},{x.col}) {reason}")
proc raiseErrorWithReason*(x: Statement, reason: string): void =
  raise newException(ValueError, &"[Compiler] ({x.line},{x.col}) {reason}")
proc raiseErrorWithReason*(x: Block, reason: string): void =
  raise newException(ValueError, &"[Compiler] ({x.line},{x.col}) {reason}")
  