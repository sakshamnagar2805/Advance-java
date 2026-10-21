package com.shopsphere.util;

import java.math.BigDecimal;
import java.text.NumberFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.FormatStyle;
import java.util.Locale;
import java.util.ResourceBundle;

/**
 * Internationalization (i18n) Utility Class.
 * Demonstrates RTU Syllabus Section 23:
 * Locale resolution, ResourceBundle message lookups, currency formatting, and localized date presentation.
 */
public class I18nUtil {

    private static final String BUNDLE_BASE_NAME = "messages";

    public static ResourceBundle getBundle(Locale locale) {
        if (locale == null) {
            locale = Locale.ENGLISH;
        }
        return ResourceBundle.getBundle(BUNDLE_BASE_NAME, locale);
    }

    public static String getMessage(String key, Locale locale) {
        try {
            return getBundle(locale).getString(key);
        } catch (Exception e) {
            return key; // Fallback to key itself
        }
    }

    public static String formatCurrency(BigDecimal amount, Locale locale) {
        if (amount == null) {
            amount = BigDecimal.ZERO;
        }
        if (locale == null) {
            locale = Locale.of("en", "IN");
        }
        NumberFormat currencyFormat = NumberFormat.getCurrencyInstance(locale);
        return currencyFormat.format(amount);
    }

    public static String formatDate(LocalDateTime dateTime, Locale locale) {
        if (dateTime == null) {
            return "";
        }
        if (locale == null) {
            locale = Locale.ENGLISH;
        }
        DateTimeFormatter formatter = DateTimeFormatter.ofLocalizedDateTime(FormatStyle.MEDIUM).withLocale(locale);
        return dateTime.format(formatter);
    }

    public static void main(String[] args) {
        System.out.println("==================================================================");
        System.out.println("RTU Syllabus Section 23: Internationalization (i18n) Verification");
        System.out.println("==================================================================");

        Locale enLocale = Locale.ENGLISH;
        Locale hiLocale = Locale.of("hi", "IN");

        System.out.println("\n[English Locale: " + enLocale + "]");
        System.out.println("App Title  : " + getMessage("app.title", enLocale));
        System.out.println("Nav Cart   : " + getMessage("nav.cart", enLocale));
        System.out.println("Price Fmt  : " + formatCurrency(new BigDecimal("12999.50"), enLocale));

        System.out.println("\n[Hindi Locale: " + hiLocale + "]");
        System.out.println("App Title  : " + getMessage("app.title", hiLocale));
        System.out.println("Nav Cart   : " + getMessage("nav.cart", hiLocale));
        System.out.println("Price Fmt  : " + formatCurrency(new BigDecimal("12999.50"), hiLocale));

        System.out.println("\nDate Fmt   : " + formatDate(LocalDateTime.now(), enLocale));
        System.out.println("==================================================================");
    }
}
