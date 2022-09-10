

public class ExerciseChartItem{

    private double minutes;
    private String date;

    public ExerciseChartItem(double minutes, String date){
        this.minutes = minutes;
        this.date = date;
    }


    public String getDate() {
        return date;
    }

    public double getMinutes() {
        return minutes;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public void setMinutes(double minutes) {
        this.minutes = minutes;
    }
}