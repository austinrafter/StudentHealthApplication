package com.example.Controller;

import com.example.Model.Exercise;
import com.example.Model.ExerciseChartItem;
import com.example.Model.WeightExerciseChartItem;
import com.example.Model.PassExercise;
import com.example.Model.Student;
import com.example.Model.UserExercising;
import com.example.Model.MentalRefactor;
import com.example.Model.ExerciseMentalComparison;
import com.example.Model.Suggestion;
import com.example.Repository.ExerciseRepository;
import com.example.Repository.PassExerciseRepository;
import com.example.Repository.UserExercisingRepository;
import com.example.Repository.StudentRepository;

import com.example.MentalHealth.MentalHealth;
import com.example.MentalHealth.MentalRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.Duration;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.*;
import java.text.DecimalFormat;
import com.example.StudyHabits.Activity;
import com.example.StudyHabits.ActivityRepo;

@RestController
@RequestMapping(path = "/exercises")
public class ExerciseController {

    @Autowired
    private ActivityRepo actRepo;

    @Autowired
    private ExerciseRepository exerciseRepository;

    @Autowired
    private UserExercisingRepository userExercisingRepository;

    @Autowired
    private StudentRepository studentRepository;

    @Autowired
    private PassExerciseRepository passExerciseRepository;


    @Autowired
    private MentalRepository mentalRepository;


    @GetMapping("/getExercises")
    public List<Exercise> getExercises(){
        return exerciseRepository.findAll();
    }

    @GetMapping("/getUserExercises")
    public List<UserExercising> getUserExercises(){
        return userExercisingRepository.findAll();
    }

    @GetMapping("/getUserTimedExercises")
    public List<ExerciseChartItem> getUserTimedExercises(){
        List<ExerciseChartItem> exerciseChartItemArrayList = new ArrayList<ExerciseChartItem>();
        List<PassExercise> passExercises = passExerciseRepository.findAll();
        boolean datesMatch = false;

        for(PassExercise passExercise: passExercises){
            String date = passExercise.getDateof();
            String[] dateParts = date.split("T");
            ExerciseChartItem exerciseChartItem = new ExerciseChartItem((double)passExercise.getTotaltime()/60 , dateParts[0], passExercise.getCaloriesburned());
            if(exerciseChartItemArrayList.size() == 0){
                exerciseChartItemArrayList.add(exerciseChartItem);
            }
            for(ExerciseChartItem exerciseChartItem1 : exerciseChartItemArrayList){
               if(exerciseChartItem.getDate().equals(exerciseChartItem1.getDate())){
                        exerciseChartItem1.setMinutes(exerciseChartItem.getMinutes() + exerciseChartItem1.getMinutes());
                        exerciseChartItem1.setCalories(exerciseChartItem.getCalories() + exerciseChartItem1.getCalories());
                        datesMatch = true;
               }
           }
            if(!datesMatch){
                exerciseChartItemArrayList.add(exerciseChartItem);
            }else{
                datesMatch = false;
            }
        }
        for (ExerciseChartItem chartItem : exerciseChartItemArrayList){
            System.out.println(chartItem.getMinutes());
        }
        return exerciseChartItemArrayList;
    }

    @GetMapping("/getTest")
    public String getTest(){
        return "Connected";
    }

    @PostMapping("/add")
    public Exercise addExercise(@RequestBody Exercise exercise){
        exercise.setExerciseimage("https://media.giphy.com/media/vF25I06jdODgA/giphy.gif");
        return exerciseRepository.save(exercise);
    }

    @PostMapping("/addStudent")
    public Student addStudent(@RequestBody Student student){
        return studentRepository.save(student);
    }

    @GetMapping("/getStudents")
    public List<Student> getStudents(){
        return studentRepository.findAll();
    }

    @PostMapping("/getStudentIfPresent")
    public List<Student> getStudentIfPresent(@RequestBody Student student){
        List<Student>  students =  studentRepository.findByUsername(student.getUser_name());
        if(students != null){
            return students;
        }
        return null;
    }

    @PostMapping("/updateStudentWeight")
    public List<Student> updateUserWeight(@RequestBody Student student){
        List<Student> checkIfStudentPresent =  studentRepository.findByUsername(student.getUser_name());
        if(checkIfStudentPresent != null){
            if(student.getWeight() != checkIfStudentPresent.get(0).getWeight()){
                checkIfStudentPresent.get(0).setWeight(student.getWeight());
            }
            return checkIfStudentPresent;
        }
        return null;
    }

    @PostMapping("/updateStudentSchool")
    public List<Student> updateUserSchool(@RequestBody Student student){
        List<Student> checkIfStudentPresent =  studentRepository.findByUsername(student.getUser_name());
        if(checkIfStudentPresent != null){
            if(student.getSchool() != checkIfStudentPresent.get(0).getSchool()){
                checkIfStudentPresent.get(0).setSchool(student.getSchool());
            }
            return checkIfStudentPresent;
        }
        return null;
    }


    @PostMapping("/addtouser")
    public PassExercise addUserExercise(@RequestBody PassExercise passExercise){
        //List<Exercise> exercises = exerciseRepository.findByExercisename(passExercise.getExercisename());
        //List<Student> students = studentRepository.findByUsername(passExercise.getUsername());
        //DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
        //LocalDateTime dateTimeEnded = LocalDateTime.parse(passExercise.getDateof(), formatter);
        //UserExercising userExercising = new UserExercising(exercises.get(0), students.get(0), dateTimeEnded, dateTimeEnded, passExercise.getTotaltime(), passExercise.getCaloriesburned());
        //userExercisingRepository.save(userExercising);
       return passExerciseRepository.save(passExercise);
    }

    @PutMapping("/update/{id}")
    public ResponseEntity updateExerciseForUser(@PathVariable Long id, @PathVariable LocalDateTime ended){
        boolean exist = userExercisingRepository.existsById(id);
        if(exist){
            UserExercising userExercising = userExercisingRepository.getById(id);
            Exercise exercise = userExercising.getExercise();
            Student student = userExercising.getStudent();
            double metabolicEquivalentScore = exercise.getMetabolic_equivalent_score();
            double studentWeight = student.getWeight();
            double weightInKilograms = studentWeight * 0.453592;
            double caloriesBurned = (metabolicEquivalentScore * 3.5 * weightInKilograms) / 200;
            userExercising.setCalories_burned(caloriesBurned);
            userExercising.setEnded_at(ended);
            userExercisingRepository.save(userExercising);
            Duration totalTime = Duration.between(userExercising.getStarted_at(),userExercising.getEnded_at());
            return new ResponseEntity<>("Calories burned for " + totalTime + " minutes exercised: " + caloriesBurned, HttpStatus.OK);
        }
        return new ResponseEntity<>("Did not begin an exercise", HttpStatus.BAD_REQUEST);
    }

    @DeleteMapping("/delete/{id}")
    public ResponseEntity deleteExerciseForUser(@PathVariable Long id){
        boolean exist = userExercisingRepository.existsById(id);
        if(exist){
            userExercisingRepository.deleteById(id);
            return new ResponseEntity<>("Exercise deleted for user", HttpStatus.OK);
        }
        return new ResponseEntity<>("Exercise did not exist for user", HttpStatus.BAD_REQUEST);
    }


    @PostMapping("/getTotalExerciseTimeForDay")
    public int getTotalExerciseTimeForDay(@PathVariable String date){
        int totalTime = 0;
        List<PassExercise> passExerciseList = passExerciseRepository.findByDateofContaining(date);
        for(PassExercise passExercise: passExerciseList){
            totalTime += passExercise.getTotaltime();
        }
        return totalTime;
    }


    @PostMapping("/getExercisesByType")
    public List<Exercise> getExercisesByType(@RequestBody Exercise exercise){
        return exerciseRepository.findByExercisetype(exercise.getExercisetype());
    }

    @PostMapping("/getExercisesByDate")
    public List<PassExercise> getExercisesByDate(@RequestBody PassExercise passExercise){
        System.out.println(passExercise.getDateof());
        return passExerciseRepository.findByDateofContaining(passExercise.getDateof());
    }

    @PostMapping("/getFavoriteExerciseForDate")
    public PassExercise getFavoriteExerciseForDate(@RequestBody PassExercise passExercise){
        //System.out.println(passExercise.getDateof());
        int max = 0;
        String exercisename1 = "";
        Map<String, Integer> maxExerciseName = new HashMap<String, Integer>();
        HashSet<String> exerciseNames = new HashSet<String>();

        List<PassExercise> passExerciseList = passExerciseRepository.findByDateofContaining(passExercise.getDateof());
        PassExercise passExercise1 = passExerciseList.get(0);

        for (PassExercise passExercise2: passExerciseList) {
            if(!exerciseNames.contains(passExercise2.getExercisename())){
                exerciseNames.add(passExercise2.getExercisename());
                maxExerciseName.put(passExercise2.getExercisename(),1);
            }else{
                maxExerciseName.put(passExercise2.getExercisename(), maxExerciseName.get(passExercise2.getExercisename()) + 1);
            }
        }

        for(String i : maxExerciseName.keySet()){
            if(maxExerciseName.get(i) > max){
                max = maxExerciseName.get(i);
                exercisename1 = i;
            }
        }

        for(PassExercise passExercise2: passExerciseList){
            if(exercisename1 == passExercise2.getExercisename()){
                passExercise1 = passExercise2;
                break;
            }
        }

        System.out.println(passExercise1.getPassexerciseid());
        System.out.println(passExercise1.getExercisename());
        return passExercise1;
    }


    @GetMapping("/getUserWeightedExercises")
    public List<WeightExerciseChartItem> getUserWeighedExercises(){
        List<WeightExerciseChartItem> exerciseChartItemArrayList = new ArrayList<WeightExerciseChartItem>();
        List<PassExercise> passExercises = passExerciseRepository.findAll();
        boolean datesMatch = false;

        for(PassExercise passExercise: passExercises){
            String date = passExercise.getDateof();
            String[] dateParts = date.split("T");
            WeightExerciseChartItem exerciseChartItem = new WeightExerciseChartItem( passExercise.getExercisename(), passExercise.getWeightrepped(), passExercise.getReps() , dateParts[0]);
            if(exerciseChartItem.getWeight() > 0) {
                exerciseChartItemArrayList.add(exerciseChartItem);
            }
        }
        for (WeightExerciseChartItem chartItem : exerciseChartItemArrayList){
            System.out.println(chartItem.getExercise());
            System.out.println(chartItem.getWeight());
            System.out.println(chartItem.getDate());
        }
        return exerciseChartItemArrayList;
    }


    @GetMapping("/getDailyExerciseMoodStressLevels")
    public List<ExerciseMentalComparison> getDailyExerciseMoodStressLevels(){
        List<ExerciseChartItem> exerciseChartItemArrayList = new ArrayList<ExerciseChartItem>();
        List<MentalRefactor> mentalRefactorArrayList = new ArrayList<MentalRefactor>();
        List<MentalRefactor> mentalRefactorArrayList2 = new ArrayList<MentalRefactor>();
        List<ExerciseMentalComparison> exerciseMentalComparisonArrayList = new ArrayList<ExerciseMentalComparison>();
        List<PassExercise> passExercises = passExerciseRepository.findAll();
        List<MentalHealth> mentalHealthList = mentalRepository.findAll();
        boolean datesMatch = false;

        for(MentalHealth mentalHealth: mentalHealthList){
            String month = mentalHealth.getMonth();
            String day = mentalHealth.getDay();
            if(month.length() < 2){
                month = "0" + month;
            }

            if(day.length() < 2){
                day = "0" + day;
            }
            int moodTotal = 0;
            int stressTotal = 0;
            if(mentalHealth.getMood().equals("negative")){
                moodTotal = 2;
            }else if(mentalHealth.getMood().equals("neutral")){
                moodTotal = 1;
            }

            if(mentalHealth.getStress().equals("high")){
                stressTotal = 2;
            }else if(mentalHealth.getStress().equals("regular")){
                stressTotal = 1;
            }
            String date = mentalHealth.getYear() + "-" + month + "-" + day;
            MentalRefactor mentalRefactor = new MentalRefactor(mentalHealth.getMood(), mentalHealth.getStress(), date, moodTotal, stressTotal);
            mentalRefactorArrayList.add(mentalRefactor);
        }
        mentalRefactorArrayList2.add(mentalRefactorArrayList.get(0));
        for(MentalRefactor mentalRefactor1: mentalRefactorArrayList){
            boolean dateNotFound = true;
            for(MentalRefactor mentalRefactor: mentalRefactorArrayList2) {
                if (mentalRefactor1.getDate().equals(mentalRefactor.getDate())){
                    mentalRefactor.setMoodTotal(mentalRefactor.getMoodTotal() + mentalRefactor1.getMoodTotal());
                    mentalRefactor.setStressTotal(mentalRefactor.getStressTotal() + mentalRefactor1.getStressTotal());
                    mentalRefactor.setDayTotal(mentalRefactor.getDayTotal() + mentalRefactor1.getDayTotal());
                    dateNotFound = false;
                }
            }

            if(dateNotFound){
                mentalRefactorArrayList2.add(mentalRefactor1);
            }else{
                dateNotFound = true;
            }

        }

        for(MentalRefactor mentalRefactor: mentalRefactorArrayList2) {
           mentalRefactor.setMoodTotal(mentalRefactor.getMoodTotal() / mentalRefactor.getDayTotal());
           mentalRefactor.setStressTotal(mentalRefactor.getStressTotal() / mentalRefactor.getDayTotal());
            if(mentalRefactor.getMoodTotal() == 2){
                mentalRefactor.setMood("negative");
            }else if(mentalRefactor.getMoodTotal() == 1){
                mentalRefactor.setMood("neutral");
            }else{
                mentalRefactor.setMood("positive");
            }

            if(mentalRefactor.getStressTotal() == 2){
                mentalRefactor.setStress("high");
            }else if(mentalRefactor.getStressTotal() == 1){
                mentalRefactor.setStress("regular");
            }else{
                mentalRefactor.setStress("low");
            }
        }

        for(PassExercise passExercise: passExercises){
            String date = passExercise.getDateof();
            String[] dateParts = date.split("T");
            ExerciseChartItem exerciseChartItem = new ExerciseChartItem((double)passExercise.getTotaltime()/60 , dateParts[0], passExercise.getCaloriesburned());
            if(exerciseChartItemArrayList.size() == 0){
                exerciseChartItemArrayList.add(exerciseChartItem);
            }
            for(ExerciseChartItem exerciseChartItem1 : exerciseChartItemArrayList){
                if(exerciseChartItem.getDate().equals(exerciseChartItem1.getDate())){
                    exerciseChartItem1.setMinutes(exerciseChartItem.getMinutes() + exerciseChartItem1.getMinutes());
                    datesMatch = true;
                }
            }
            if(!datesMatch){
                exerciseChartItemArrayList.add(exerciseChartItem);
            }else{
                datesMatch = false;
            }
        }
        for (ExerciseChartItem chartItem : exerciseChartItemArrayList){
            System.out.println(chartItem.getMinutes());
        }
        for(MentalRefactor mentalRefactor: mentalRefactorArrayList2) {
            for (ExerciseChartItem chartItem : exerciseChartItemArrayList){
                if(mentalRefactor.getDate().equals(chartItem.getDate())){
                    ExerciseMentalComparison exerciseMentalComparison = new ExerciseMentalComparison(chartItem.getMinutes(),chartItem.getDate(), mentalRefactor.getMood(), mentalRefactor.getStress());
                    exerciseMentalComparisonArrayList.add(exerciseMentalComparison);
                }
            }
        }
        for(ExerciseMentalComparison exerciseMentalComparison: exerciseMentalComparisonArrayList){
            System.out.println("Minutes: " + exerciseMentalComparison.getMinutes());
        }
        return exerciseMentalComparisonArrayList;
    }

    @GetMapping("/giveExerciseMoodSuggestion")
    public Suggestion giveExerciseMoodSuggestion(){
        int dayTotal = 0;
        double minuteTotal = 0;
        int moodFinal = 0;
        List<ExerciseMentalComparison> exerciseMentalComparisonArrayList = getDailyExerciseMoodStressLevels();
        for(ExerciseMentalComparison exerciseMentalComparison : exerciseMentalComparisonArrayList){
            int moodTotal = 0;
            if(exerciseMentalComparison.getMood().equals("negative")){
                moodTotal = 2;
            }else if(exerciseMentalComparison.getMood().equals("neutral")){
                moodTotal = 1;
            }
            moodFinal = moodFinal + moodTotal;
            dayTotal += 1;
            minuteTotal = minuteTotal + exerciseMentalComparison.getMinutes();
        }
        minuteTotal = minuteTotal / dayTotal;;
        moodFinal = moodFinal / dayTotal;
        System.out.println(minuteTotal);
        System.out.println(moodFinal);


        String mood = "";
        if(moodFinal == 2){
            mood =  "negative";
        }else if(moodFinal == 1){
            mood = "neutral";
        }else{
            mood = "positive";
        }

        String suggestion = "";
        Suggestion suggestion1;
        if(minuteTotal < 30 && moodFinal >= 1){
            String sug = "You tend to exercise for " + String.format("%.2f", minuteTotal) + " minutes a day, and have a " + mood + " mood. Exercising for at least 30 minutes a day has been shown to improve mood.";
            suggestion1 = new Suggestion("Exercise", "Mood", sug);
        }else if(minuteTotal >= 30 && moodFinal >= 1){
            String sug = "Your daily exercise times meet or exceed the suggested 30 minutes. You may want to check our other suggestions to improve your average " + mood + " mood.";
            suggestion1 = new Suggestion("Exercise", "Mood", sug);
        }else if(minuteTotal >= 30 && moodFinal < 1){
            String sug = "HUZZAH!!! You're daily exercise times and moods are great!!!";
            suggestion1 = new Suggestion("Exercise", "Mood", sug);
        }else{
            String sug = "You have good mood on average, but you tend to exercise for " + String.format("%.2f", minuteTotal) + " minutes on days you enter a mood. Exercising at least 30 minutes each day can benefit your health in general.";
            suggestion1 = new Suggestion("Exercise", "Mood", sug);
        }

        System.out.println(suggestion1.getFunctionOne());
        System.out.println(suggestion1.getFunctionTwo());
        System.out.println(suggestion1.getSuggestion());
        return suggestion1;
    }

    @GetMapping("/giveExerciseStressSuggestion")
    public Suggestion giveExerciseStressSuggestion(){
        int dayTotal = 0;
        double minuteTotal = 0;
        int stressFinal = 0;
        List<ExerciseMentalComparison> exerciseMentalComparisonArrayList = getDailyExerciseMoodStressLevels();
        for(ExerciseMentalComparison exerciseMentalComparison : exerciseMentalComparisonArrayList){
            int stressTotal = 0;
            if(exerciseMentalComparison.getStress().equals("high")){
                stressTotal = 2;
            }else if(exerciseMentalComparison.getStress().equals("regular")){
                stressTotal = 1;
            }
            stressFinal = stressFinal + stressTotal;
            dayTotal += 1;
            minuteTotal = minuteTotal + exerciseMentalComparison.getMinutes();
        }
        minuteTotal = minuteTotal / dayTotal;
        stressFinal = stressFinal / dayTotal;
        System.out.println(minuteTotal);
        System.out.println(stressFinal);

        String stress = "";
        if(stressFinal == 2){
            stress = "high";
        }else if(stressFinal == 1){
            stress = "regular";
        }else{
            stress = "low";
        }

        String suggestion = "";
        Suggestion suggestion1;
        if(minuteTotal < 30 && stressFinal >= 1){
            String sug = "You tend to exercise for " + String.format("%.2f", minuteTotal) + " minutes a day, and have a " + stress + " stress level. Exercising for at least 30 minutes a day has been shown to improve stress levels.";
            suggestion1 = new Suggestion("Exercise", "Stress", sug);
        }else if(minuteTotal >= 30 && stressFinal >= 1){
            String sug = "Your daily exercise times meet or exceed the suggested 30 minutes. You may want to check our other suggestions to improve your average " + stress + " stress levels.";
            suggestion1 = new Suggestion("Exercise", "Stress", sug);
        }else if(minuteTotal >= 30 && stressFinal < 1){
            String sug = "HUZZAH!!! You're daily exercise times and stress levels are great!!!";
            suggestion1 = new Suggestion("Exercise", "Stress", sug);
        }else{
            String sug = "You have good stress level on average, but you tend to exercise for " + String.format("%.2f", minuteTotal) + " on days you enter your stress level. Exercising at least 30 minutes each day can benefit your health in general.";
            suggestion1 = new Suggestion("Exercise", "Stress", sug);
        }

        System.out.println(suggestion1.getFunctionOne());
        System.out.println(suggestion1.getFunctionTwo());
        System.out.println(suggestion1.getSuggestion());
        return suggestion1;
    }

    @GetMapping("/exercise")
    public int getExerciseTime(){
        int time = 0;
        System.out.println("FIRST TEST");
        Collection<Integer> exerciseTime = passExerciseRepository.findExerciseCount();
        Object[] thisExerciseAmount = exerciseTime.toArray(new Object[exerciseTime.size()]);
        int[] intTime = new int[thisExerciseAmount.length];
        System.out.println("SECOND TEST");

        for(int i = 0; i < thisExerciseAmount.length; i ++){
            intTime[i] = (Integer) thisExerciseAmount[i];
            System.out.println(intTime[i]);
            time += intTime[i];
        }
        return time;
    }


    @GetMapping("/giveExerciseStudySuggestion")
    public Suggestion giveExerciseStudySuggestion(){
        List<PassExercise> passExercises = passExerciseRepository.findAll();
        List<ExerciseChartItem> exerciseChartItemArrayList = new ArrayList<ExerciseChartItem>();
        int dayTotal = 0;
        double minuteTotal = 0;
        int stressFinal = 0;
        boolean datesMatch = false;

        for(PassExercise passExercise: passExercises){
            String date = passExercise.getDateof();
            String[] dateParts = date.split("T");
            ExerciseChartItem exerciseChartItem = new ExerciseChartItem((double)passExercise.getTotaltime()/60 , dateParts[0], passExercise.getCaloriesburned());
            if(exerciseChartItemArrayList.size() == 0){
                exerciseChartItemArrayList.add(exerciseChartItem);
            }
            for(ExerciseChartItem exerciseChartItem1 : exerciseChartItemArrayList){
                if(exerciseChartItem.getDate().equals(exerciseChartItem1.getDate())){
                    exerciseChartItem1.setMinutes(exerciseChartItem.getMinutes() + exerciseChartItem1.getMinutes());
                    datesMatch = true;
                }
            }
            if(!datesMatch){
                exerciseChartItemArrayList.add(exerciseChartItem);
            }else{
                datesMatch = false;
            }
        }

        for(ExerciseChartItem exerciseChartItem1 : exerciseChartItemArrayList){
            minuteTotal = minuteTotal + exerciseChartItem1.getMinutes();
            dayTotal = dayTotal + 1;
        }

       minuteTotal = minuteTotal / dayTotal;
        List<Activity> activtyList = actRepo.findAll();

        int totalActivities = 0;
        double activityTotalTime = 0;
        for(Activity activity: activtyList){
            activityTotalTime = activityTotalTime + (activity.getDuration()/60);
            totalActivities = totalActivities + 1;
        }

        activityTotalTime = activityTotalTime / 60;

        Suggestion suggestion1;
        if(minuteTotal < 30 && activityTotalTime >= 20){
            String sug = "You tend to exercise for " + String.format("%.2f", minuteTotal) + " minutes a day, but only study for  " + String.format("%.2f", activityTotalTime) + " at a time. Exercising for at least 30 minutes a day has been shown to improve concentration.";
            suggestion1 = new Suggestion("Exercise", "Study", sug);
        }else if(minuteTotal >= 30 && stressFinal >= 20){
            String sug = "Your daily exercise times meet or exceed the suggested 30 minutes. You may want to check our other suggestions to improve your average " + String.format("%.2f", activityTotalTime) + " study times.";
            suggestion1 = new Suggestion("Exercise", "Study", sug);
        }else if(minuteTotal >= 30 && stressFinal < 20){
            String sug = "HUZZAH!!! You're daily exercise times and study times are great!!!";
            suggestion1 = new Suggestion("Exercise", "Study", sug);
        }else{
            String sug = "You have good study times on average, but you tend to exercise for " + String.format("%.2f", minuteTotal) + ". Exercising at least 30 minutes each day can benefit your health in general.";
            suggestion1 = new Suggestion("Exercise", "Study", sug);
        }


        System.out.println(suggestion1.getFunctionOne());
        System.out.println(suggestion1.getFunctionTwo());
        System.out.println(suggestion1.getSuggestion());
        return suggestion1;
    }



}
