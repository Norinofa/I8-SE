package com.example.teamsverwaltung;

import com.google.ortools.sat.CpModel;
import com.google.ortools.sat.CpSolver;

import com.google.ortools.sat.CpSolverStatus;
import com.google.ortools.sat.IntVar;
import com.google.ortools.util.Domain;
import java.util.HashMap;
import java.util.Map;

public class AssignmentAlgo {
    private Map<String, IntVar> modelVars;
    private CpModel model;
    private int nProjects;
    private static int nStudents;
    private int nPjctSlots;
    private int nWings;
    private int nRoles;

    public AssignmentAlgo(Map<Integer, double[]> projectAnswers, Map<Integer, double[]> roleAnswers, double[] wingAnswers) {
        modelVars = new HashMap<>();
        model = new CpModel();
        nProjects = projectAnswers.get(0).length;
        nStudents = projectAnswers.size();
        nPjctSlots = (int) Math.ceil(nStudents / (double) nProjects);
        nWings = 0;
        for (double answer : wingAnswers) {
            nWings += (int) answer;
        }
        nRoles = 5;
    }

    public void run() {
        initVarSet();
        initBounds();
        addHcOnePrjPerStud();
        addHcStudsAssignedEqually();
        addHcRolesAssignedEqually();
        addSc();

        CpSolver solver = new CpSolver();
        solver.getParameters().setMaxTimeInSeconds(300);
        CpSolverStatus status = solver.solve(model);
        if (status == CpSolverStatus.OPTIMAL || status == CpSolverStatus.FEASIBLE) {
            extractSolution(solver);
        } else {
            throw new AssignmentAlgoException("Equation infeasible for given data");
        }
    }

    private void initVarSet() {
        for (int i = 0; i < nProjects; i++) {
            for (int k = 0; k < nStudents; k++) {
                for (int l = 0; l < nRoles; l++) {
                    String varName = "(" + i + "," + k + "," + l + ")";
                    modelVars.put(varName, model.newBoolVar(varName));
                }
            }
        }
    }

    private void initBounds() {
        int nStudsPerRoleLb = ((nStudents / nProjects) - 1) / (nRoles - 1);
        int nStudsPerRoleUb = (int) Math.ceil((nPjctSlots - 1) / (double) (nRoles - 1));

        int lbStudsPerPrj = nStudents / nProjects;
        int hbStudsPerPrj = (nStudents % nProjects == 0) ? lbStudsPerPrj : lbStudsPerPrj + 1;

        int lbWingsPerPrj = nWings / nProjects;
        int hbWingsPerPrj = (nWings % nProjects == 0) ? lbWingsPerPrj : lbWingsPerPrj + 1;

        // Set variable domains
        // Set variable domains
        for (int i = 0; i < nProjects; i++) {
            for (int k = 0; k < nStudents; k++) {
                for (int l = 0; l < nRoles; l++) {
                    String varName = "(" + i + "," + k + "," + l + ")";
                    IntVar var = modelVars.get(varName);
                    model.addDifferent(var,var);
                }
            }
        }
    }

    private void addHcOnePrjPerStud() {
        for (int k = 0; k < nStudents; k++) {
            IntVar[] projVars = new IntVar[nProjects];
            for (int i = 0; i < nProjects; i++) {
                String varName = "(" + i + "," + k + ",0)";
                projVars[i] = modelVars.get(varName);
            }
           // model.addEquality(model.scalProd(projVars, new int[nProjects]), 1);
        }
    }

    private void addHcStudsAssignedEqually() {
        for (int i = 0; i < nProjects; i++) {
            IntVar[] studVars = new IntVar[nStudents];
            for (int k = 0; k < nStudents; k++) {
                String varName = "(" + i + "," + k + ",0)";
                studVars[k] = modelVars.get(varName);
            }
        //    model.addEquality(model.newLinearExpr().addAll(studVars), nPjctSlots);
        }

        for (int i = 0; i < nProjects; i++) {
            IntVar[] wingVars = new IntVar[nStudents];
            for (int k = 0; k < nStudents; k++) {
                String varName = "(" + i + "," + k + ",0)";
                wingVars[k] = modelVars.get(varName);
            }
        //    model.addEquality(model.newLinearExpr().addAll(wingVars), nPjctSlots);
        }
    }

    private void addHcRolesAssignedEqually() {
        for (int i = 0; i < nProjects; i++) {
            for (int l = 1; l < nRoles; l++) {
                IntVar[] roleVars = new IntVar[nStudents];
                for (int k = 0; k < nStudents; k++) {
                    String varName = "(" + i + "," + k + "," + l + ")";
                    roleVars[k] = modelVars.get(varName);
                }
     //           model.addBetween(model.newLinearExpr().addAll(roleVars), nStudsPerRoleLb, nStudsPerRoleUb);
            }
        }
    }

    private void addSc() {
        // Soft constraints implementation goes here
    }

    private void extractSolution(CpSolver solver) {
        // Solution extraction goes here
    }

    public static void main(String[] args) {
        // Initialize input data
        Map<Integer, double[]> projectAnswers = new HashMap<>();
        Map<Integer, double[]> roleAnswers = new HashMap<>();
        double[] wingAnswers = new double[nStudents];

        // Populate input data

        AssignmentAlgo algorithm = new AssignmentAlgo(projectAnswers, roleAnswers, wingAnswers);
        algorithm.run();
    }
}

class AssignmentAlgoException extends RuntimeException {
    public AssignmentAlgoException(String message) {
        super(message);
    }
}
