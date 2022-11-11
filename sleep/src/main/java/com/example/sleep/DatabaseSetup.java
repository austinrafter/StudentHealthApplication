package com.example.sleep;

import com.example.sleep.model.Sleep;
import com.example.sleep.repository.SleepRepository;
import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.stereotype.Component;

import java.time.Instant;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Random;
import java.util.concurrent.ThreadLocalRandom;

@Component
@Log4j2
public class DatabaseSetup implements ApplicationRunner {

    private final SleepRepository sleepRepository;

    @Autowired
    public DatabaseSetup(SleepRepository sleepRepository) {
        this.sleepRepository = sleepRepository;
    }

    @Override
    public void run(ApplicationArguments args) throws Exception {

        final DateTimeFormatter dateTimeFormatter = DateTimeFormatter
                .ofPattern("MM/dd/yyyy - HH:mm:ss z")
                .withZone(ZoneId.of("America/Los_Angeles"));

        // https://random.limited/date-time-generator
        List<Integer> startsInt = List.of(
                1665814551,
                1665816398,
                1666073737,
                1666160241,
                1666161386,
                1666161441,
                1666247502,
                1666247868,
                1666248306,
                1666419140,
                1666419255,
                1666765526,
                1667025500,
                1667201620,
                1667288240,
                1667288736,
                1667634020,
                1667978756,
                1668064783,
                1668067161
        );

        List<Long> starts = new ArrayList<>();
        startsInt.forEach(start -> {
            starts.add(start.longValue());
        });

        List<Long> ends = new ArrayList<>();
        // https://www.epochconverter.com/
        // ~6h to ~7h: 22000 to 26000
        starts.forEach(start -> {
            ends.add(start + ThreadLocalRandom.current().nextLong(22000, 26000));
        });

        Iterator<Long> it1 = starts.iterator();
        Iterator<Long> it2 = ends.iterator();
        while (it1.hasNext()) {
            Long start = it1.next();
            Long end = it2.next();

            String startString = ZonedDateTime.ofInstant(
                    Instant.ofEpochSecond(start),
                    ZoneId.of("America/Los_Angeles")
            ).format(dateTimeFormatter);
            String endString = ZonedDateTime.ofInstant(
                    Instant.ofEpochSecond(end),
                    ZoneId.of("America/Los_Angeles")
            ).format(dateTimeFormatter);

            String record = "Start: " + startString + " End: " + endString;
            log.info(record);

            Sleep newSleep = new Sleep(start, end);
            sleepRepository.save(newSleep);
        }

    }
}
