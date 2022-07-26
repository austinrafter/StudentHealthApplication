import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.support.FormattingConversionService;
import org.springframework.format.datetime.standard.DateTimeFormatterRegistrar;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import java.time.format.DateTimeFormatter;

@Configuration(proxyBeanMethods = false)
class DateFormatConfiguration {
    private final DateTimeFormatterRegistrar registrar =
            new DateTimeFormatterRegistrar();

    public DateFormatConfiguration() {
        registrar.setDateFormatter(
                DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        registrar.setTimeFormatter(
                DateTimeFormatter.ofPattern("HH:mm:ss"));
        registrar.setDateTimeFormatter(
                DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss"));
    }

    @Autowired
    public void configure(
            final FormattingConversionService conversionService) {
        registrar.registerFormatters(conversionService);
    }
}