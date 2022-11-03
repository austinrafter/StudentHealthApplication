package com.example.Controller;

import com.example.Model.*;
import com.example.Repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import com.example.Model.ExerciseChartItem;

import com.example.MentalHealth.MentalHealth;
import com.example.MentalHealth.MentalRepository;

import java.time.Duration;
import java.time.LocalDateTime;
import java.util.List;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.text.DecimalFormat;

import com.example.StudyHabits.Activity;
import com.example.StudyHabits.ActivityRepo;

@RestController
@RequestMapping(path = "/meditations")
public class MeditationController {

    @Autowired
    private ActivityRepo actRepo;

    @Autowired
    private MeditationRepository meditationRepository;

    @Autowired
    private UserMeditatingRepository userMeditatingRepository;

    @Autowired
    private PassMeditationRepository passMeditationRepository;

    @Autowired
    private StudentRepository studentRepository;

    @Autowired
    private MentalRepository mentalRepository;

    @GetMapping("/getMeditations")
    public List<Meditation> getMegetUserTimedMeditationditations(){
        System.out.println("gets here: get meditations");
        return meditationRepository.findAll();
    }

    @GetMapping("/getUserMeditations")
    public List<UserMeditating> getUserMeditations(){
        return userMeditatingRepository.findAll();
    }

    @PostMapping("/addmeditation")
    public Meditation addMeditation(@RequestBody Meditation meditation){
        return meditationRepository.save(meditation);
    }

    @PostMapping("/addmeditationtouser")
    public PassMeditation addUserMeditation(@RequestBody PassMeditation passMeditation){
        //List<Meditation> meditations = meditationRepository.findByMeditationname(passMeditation.getMeditationname());
       // List<Student> students = studentRepository.findByUsername(passMeditation.getUsername());
       // DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
       // LocalDateTime dateTimeEnded = LocalDateTime.parse(passMeditation.getDateof(), formatter);
        //UserMeditating userMeditating = new UserMeditating(meditations.get(0), students.get(0), dateTimeEnded, dateTimeEnded, passMeditation.getTotaltime());
        //userMeditatingRepository.save(userMeditating);
        return passMeditationRepository.save(passMeditation);
    }

    @PutMapping("/update/{id}")
    public ResponseEntity updateTask(@PathVariable Long id, @PathVariable LocalDateTime ended){
        boolean exist = userMeditatingRepository.existsById(id);
        if(exist){
            UserMeditating userMeditating = userMeditatingRepository.getById(id);
            userMeditating.setEnded_at(ended);
            userMeditatingRepository.save(userMeditating);
            Duration totalTime = Duration.between(userMeditating.getStarted_at(),userMeditating.getEnded_at());
            return new ResponseEntity<>("Finished meditating for " + totalTime + " minutes.", HttpStatus.OK);
        }
        return new ResponseEntity<>("Did not begin an exercise", HttpStatus.BAD_REQUEST);
    }

    @DeleteMapping("/delete/{id}")
    public ResponseEntity deleteTask(@PathVariable Long id){
        boolean exist = userMeditatingRepository.existsById(id);
        if(exist){
            userMeditatingRepository.deleteById(id);
            return new ResponseEntity<>("Exercise deleted for user", HttpStatus.OK);
        }
        return new ResponseEntity<>("Exercise did not exist for user", HttpStatus.BAD_REQUEST);
    }

    @PostMapping("/getMeditationsByType")
    public List<Meditation> getMeditationsByType(@RequestBody Meditation meditation){
        return meditationRepository.findByMeditationtype(meditation.getMeditationtype());
    }

    @PostMapping("/getMeditationsByDate")
    public List<PassMeditation> getMeditationsByDate(@RequestBody PassMeditation passMeditation){
        System.out.println(passMeditation.getDateof());
        return passMeditationRepository.findByDateofContaining(passMeditation.getDateof());
    }

    @PostMapping("/getFavoriteMeditationForDate")
    public PassMeditation getFavoriteExerciseForDate(@RequestBody PassMeditation passMeditation){
        //System.out.println(passExercise.getDateof());
        int max = 0;
        String meditationname1 = "";
        Map<String, Integer> maxMeditationName = new HashMap<String, Integer>();
        HashSet<String> meditationNames = new HashSet<String>();

        List<PassMeditation> passMeditationList = passMeditationRepository.findByDateofContaining(passMeditation.getDateof());
        PassMeditation passMeditation1 = passMeditationList.get(0);

        for (PassMeditation passMeditation2: passMeditationList) {
            if(!meditationNames.contains(passMeditation2.getMeditationname())){
                meditationNames.add(passMeditation2.getMeditationname());
                maxMeditationName.put(passMeditation2.getMeditationname(),1);
            }else{
                maxMeditationName.put(passMeditation2.getMeditationname(), maxMeditationName.get(passMeditation2.getMeditationname()) + 1);
            }
        }

        for(String i : maxMeditationName.keySet()){
            if(maxMeditationName.get(i) > max){
                max = maxMeditationName.get(i);
                meditationname1 = i;
            }
        }

        for(PassMeditation passMeditation2: passMeditationList){
            if(meditationname1 == passMeditation2.getMeditationname()){
                passMeditation1 = passMeditation2;
                break;
            }
        }

        System.out.println(passMeditation1.getMeditationname());
        return passMeditation1;
    }

    @GetMapping("/getUserTimedMeditation")
    public List<MeditationChartItem> getUserTimedMeditation(){
        List<MeditationChartItem> meditationChartItemArrayList = new ArrayList<MeditationChartItem>();
        List<PassMeditation> passMeditations = passMeditationRepository.findAll();
        boolean datesMatch = false;

        for(PassMeditation passMeditation: passMeditations){
            //get datetime
            String date = passMeditation.getDateof();
            //split datetime to get only date
            String[] dateParts = date.split("T");
            MeditationChartItem meditationChartItem = new MeditationChartItem(((double)passMeditation.getTotaltime()/60) , dateParts[0]);
            if(meditationChartItemArrayList.size() == 0){
                meditationChartItemArrayList.add(meditationChartItem);
            }
            for(MeditationChartItem meditationChartItem1 : meditationChartItemArrayList){
                if((meditationChartItem.getDate().equals(meditationChartItem1.getDate()))){
                    meditationChartItem1.setMinutes(meditationChartItem.getMinutes() + meditationChartItem1.getMinutes());
                    datesMatch = true;
                }
            }
            if(!datesMatch){
                meditationChartItemArrayList.add(meditationChartItem);
            }else{
                datesMatch = false;
            }
        }
        for (MeditationChartItem chartItem : meditationChartItemArrayList){
            System.out.println(chartItem.getMinutes());
        }
        return meditationChartItemArrayList;
    }

    @GetMapping("/meditation")
    public int getUserTimedExercises() {
        int time = 0;
        System.out.println("FIRST TEST");
        Collection<Integer> meditationTime = passMeditationRepository.findMeditationCount();
        Object[] thisMeditationAmount = meditationTime.toArray(new Object[meditationTime.size()]);
        int[] intTime = new int[thisMeditationAmount.length];
        System.out.println("SECOND TEST");

        for(int i = 0; i < thisMeditationAmount.length; i ++){
            intTime[i] = (Integer) thisMeditationAmount[i];
            System.out.println(intTime[i]);
            time += intTime[i];
        }
        return time;
    }

    @GetMapping("/getDailyMeditationMoodStressLevels")
    public List<ExerciseMentalComparison> getDailyMeditationMoodStressLevels(){
        List<MeditationChartItem> meditationChartItemList = new ArrayList<MeditationChartItem>();
        List<MentalRefactor> mentalRefactorArrayList = new ArrayList<MentalRefactor>();
        List<MentalRefactor> mentalRefactorArrayList2 = new ArrayList<MentalRefactor>();
        List<ExerciseMentalComparison> exerciseMentalComparisonArrayList = new ArrayList<ExerciseMentalComparison>();
        List<PassMeditation> passMeditations = passMeditationRepository.findAll();
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

        for(PassMeditation passMeditation: passMeditations){
            String date = passMeditation.getDateof();
            String[] dateParts = date.split("T");
            MeditationChartItem exerciseChartItem = new MeditationChartItem((double)passMeditation.getTotaltime()/60 , dateParts[0]);
            if(meditationChartItemList.size() == 0){
                meditationChartItemList.add(exerciseChartItem);
            }
            for(MeditationChartItem exerciseChartItem1 : meditationChartItemList){
                if(exerciseChartItem.getDate().equals(exerciseChartItem1.getDate())){
                    exerciseChartItem1.setMinutes(exerciseChartItem.getMinutes() + exerciseChartItem1.getMinutes());
                    datesMatch = true;
                }
            }
            if(!datesMatch){
                meditationChartItemList.add(exerciseChartItem);
            }else{
                datesMatch = false;
            }
        }
        for (MeditationChartItem chartItem : meditationChartItemList){
            System.out.println(chartItem.getMinutes());
        }
        for(MentalRefactor mentalRefactor: mentalRefactorArrayList2) {
            for (MeditationChartItem chartItem : meditationChartItemList){
                if(mentalRefactor.getDate().equals(chartItem.getDate())){
                    ExerciseMentalComparison exerciseMentalComparison = new ExerciseMentalComparison(chartItem.getMinutes(),chartItem.getDate(), mentalRefactor.getMood(), mentalRefactor.getStress());
                    exerciseMentalComparisonArrayList.add(exerciseMentalComparison);
                }
            }
        }
        for(ExerciseMentalComparison exerciseMentalComparison: exerciseMentalComparisonArrayList){
            System.out.println("Meditation Minutes: " + exerciseMentalComparison.getMinutes());
            System.out.println("Meditation stree: " + exerciseMentalComparison.getStress());
        }
        return exerciseMentalComparisonArrayList;
    }


    @GetMapping("/giveMeditationMoodSuggestion")
    public Suggestion giveMeditationMoodSuggestion(){
        int dayTotal = 0;
        double minuteTotal = 0;
        int moodFinal = 0;
        List<ExerciseMentalComparison> exerciseMentalComparisonArrayList = getDailyMeditationMoodStressLevels();
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
        System.out.println("MEditation minutes 2: " +minuteTotal);
        System.out.println(moodFinal);


        String mood = "";
        if(moodFinal == 2){
            mood =  "negative";
        }else if(moodFinal == 1){
            mood = "neutral";
        }else{
            mood = "positive";
        }

        System.out.println(mood);

        String suggestion = "";
        Suggestion suggestion1;
        if(minuteTotal < 30 && moodFinal >= 1){
            String sug = "You tend to meditate for " + String.format("%.2f", minuteTotal) + " minutes a day, and have a " + mood + " mood. Meditating for at least 30 minutes a day has been shown to improve mood.";
            suggestion1 = new Suggestion("Meditation", "Mood", sug);
        }else if(minuteTotal >= 30 && moodFinal >= 1){
            String sug = "Your daily meditate times meet or exceed the suggested 30 minutes. You may want to check our other suggestions to improve your average " + mood + " mood.";
            suggestion1 = new Suggestion("Meditation", "Mood", sug);
        }else if(minuteTotal >= 30 && moodFinal < 1){
            String sug = "HUZZAH!!! You're daily meditation times and moods are great!!!";
            suggestion1 = new Suggestion("Meditation", "Mood", sug);
        }else{
            String sug = "You have good mood on average, but you tend to meditate for " + String.format("%.2f", minuteTotal) + " minutes on days you enter a mood. Meditating at least 30 minutes each day can benefit your health in general.";
            suggestion1 = new Suggestion("Meditation", "Mood", sug);
        }

        System.out.println(suggestion1.getFunctionOne());
        System.out.println(suggestion1.getFunctionTwo());
        System.out.println(suggestion1.getSuggestion());
        return suggestion1;
    }

    @GetMapping("/giveMeditationStressSuggestion")
    public Suggestion giveMeditationStressSuggestion(){
        int dayTotal = 0;
        double minuteTotal = 0;
        int stressFinal = 0;
        List<ExerciseMentalComparison> exerciseMentalComparisonArrayList = getDailyMeditationMoodStressLevels();
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
        System.out.println("MEditation minutes 1: " + minuteTotal);
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
            String sug = "You tend to meditate for " + String.format("%.2f", minuteTotal) + " minutes a day, and have a " + stress + " stress level. Meditating for at least 30 minutes a day has been shown to improve stress levels.";
            suggestion1 = new Suggestion("Meditation", "Stress", sug);
        }else if(minuteTotal >= 30 && stressFinal >= 1){
            String sug = "Your daily meditation times meet or exceed the suggested 30 minutes. You may want to check our other suggestions to improve your average " + stress + " stress levels.";
            suggestion1 = new Suggestion("Meditation", "Stress", sug);
        }else if(minuteTotal >= 30 && stressFinal < 1){
            String sug = "HUZZAH!!! You're daily meditation times and stress levels are great!!!";
            suggestion1 = new Suggestion("Meditation", "Stress", sug);
        }else{
            String sug = "You have good stress level on average, but you tend to meditate for " + String.format("%.2f", minuteTotal) + " minutes on days you enter your stress level. Meditating at least 30 minutes each day can benefit your health in general.";
            suggestion1 = new Suggestion("Meditation", "Stress", sug);
        }

        System.out.println(suggestion1.getFunctionOne());
        System.out.println(suggestion1.getFunctionTwo());
        System.out.println(suggestion1.getSuggestion());
        return suggestion1;
    }

    @GetMapping("/giveMeditationStudySuggestion")
    public Suggestion giveMeditationStudySuggestion(){
        List<PassMeditation> passExercises = passMeditationRepository.findAll();
        List<MeditationChartItem> exerciseChartItemArrayList = new ArrayList<MeditationChartItem>();
        int dayTotal = 0;
        double minuteTotal = 0;
        int stressFinal = 0;
        boolean datesMatch = false;

        for(PassMeditation passExercise: passExercises){
            String date = passExercise.getDateof();
            String[] dateParts = date.split("T");
            MeditationChartItem exerciseChartItem = new MeditationChartItem((double)passExercise.getTotaltime()/60 , dateParts[0]);
            if(exerciseChartItemArrayList.size() == 0){
                exerciseChartItemArrayList.add(exerciseChartItem);
            }
            for(MeditationChartItem exerciseChartItem1 : exerciseChartItemArrayList){
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

        for(MeditationChartItem exerciseChartItem1 : exerciseChartItemArrayList){
            minuteTotal = minuteTotal + exerciseChartItem1.getMinutes();
            dayTotal = dayTotal + 1;
        }

        minuteTotal = minuteTotal / dayTotal;
        List<Activity> activtyList = actRepo.findAll();

        int totalActivities = 0;
        double activityTotalTime = 0;
        for(Activity activity: activtyList){
            activityTotalTime = activityTotalTime + ( (activity.getDuration()) /60 );
            totalActivities = totalActivities + 1;
        }

        activityTotalTime = activityTotalTime / 60;

        Suggestion suggestion1;
        if(minuteTotal < 30 && activityTotalTime >= 20){
            String sug = "You tend to meditate for " + String.format("%.2f", minuteTotal) + " minutes a day, but only study for  " + String.format("%.2f", activityTotalTime) + " at a time. Exercising for at least 30 minutes a day has been shown to improve concentration.";
            suggestion1 = new Suggestion("Exercise", "Study", sug);
        }else if(minuteTotal >= 30 && stressFinal >= 20){
            String sug = "Your daily meditation times meet or exceed the suggested 30 minutes. You may want to check our other suggestions to improve your average " + String.format("%.2f", activityTotalTime) + " study times.";
            suggestion1 = new Suggestion("Exercise", "Study", sug);
        }else if(minuteTotal >= 30 && stressFinal < 20){
            String sug = "HUZZAH!!! You're daily meditation times and study times are great!!!";
            suggestion1 = new Suggestion("Exercise", "Study", sug);
        }else{
            String sug = "You have good study times on average, but you tend to meditate for " + String.format("%.2f", minuteTotal) + ". Exercising at least 30 minutes each day can benefit your health in general.";
            suggestion1 = new Suggestion("Exercise", "Study", sug);
        }


        System.out.println(suggestion1.getFunctionOne());
        System.out.println(suggestion1.getFunctionTwo());
        System.out.println(suggestion1.getSuggestion());
        return suggestion1;
    }
}
