package com.example.Model;

public class Suggestion{
    private String functionOne;
    private String functionTwo;
    private String suggestion;

    public Suggestion(String functionOne, String functionTwo, String suggestion){
        this.functionOne = functionOne;
        this.functionTwo = functionTwo;
        this.suggestion = suggestion;
    }

    public String getFunctionOne() {
        return functionOne;
    }

    public String getFunctionTwo() {
        return functionTwo;
    }

    public String getSuggestion() {
        return suggestion;
    }

    public void setFunctionOne(String functionOne) {
        this.functionOne = functionOne;
    }

    public void setSuggestion(String suggestion) {
        this.suggestion = suggestion;
    }

    public void setFunctionTwo(String functionTwo) {
        this.functionTwo = functionTwo;
    }
}