/*
Copyright 2009-2015 Urban Airship Inc. All rights reserved.
Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
1. Redistributions of source code must retain the above copyright notice, this
list of conditions and the following disclaimer.
2. Redistributions in binary form must reproduce the above copyright notice,
this list of conditions and the following disclaimer in the documentation
and/or other materials provided with the distribution.
THIS SOFTWARE IS PROVIDED BY THE URBAN AIRSHIP INC ``AS IS'' AND ANY EXPRESS OR
IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
EVENT SHALL URBAN AIRSHIP INC OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

package com.urbanairship.extension.events;

import com.urbanairship.analytics.CustomEvent;

import java.math.BigDecimal;

/**
 * A class that represents a custom account event for the application.
 */
public class AccountEvent {
    /**
     * The registered account.
     */
    public static final String REGISTERED_ACCOUNT_EVENT = "registered_account";

    /**
     * The lifetime value property.
     */
    private static final String LIFETIME_VALUE = "ltv";

    /**
     * The category property.
     */
    private static final String CATEGORY = "category";

    // optional
    private BigDecimal value;
    private String category;
    private String transactionId;

    private AccountEvent() {
    }

    /**
     * Creates a registered account event.
     *
     * @return An AccountEvent.
     */
    public static AccountEvent createRegisteredEvent() {
        return new AccountEvent();
    }

    /**
     * Set the transaction ID.
     * <p/>
     * If the transaction ID exceeds 255 characters it will cause the event to be invalid.
     *
     * @param transactionId The event's transaction ID as a string.
     * @return An AccountEvent.
     */
    public AccountEvent setTransactionId(String transactionId) {
        this.transactionId = transactionId;
        return this;
    }

    /**
     * Sets the event value.
     * <p/>
     * The event's value will be accurate 6 digits after the decimal. The number must fall in the
     * range [-2^31, 2^31-1]. Any value outside that range will cause the event to be invalid.
     *
     * @param value The event's value as a BigDecimal.
     * @return An AccountEvent.
     */
    public AccountEvent setValue(BigDecimal value) {
        this.value = value;
        return this;
    }

    /**
     * Sets the event value.
     * <p/>
     * The event's value will be accurate 6 digits after the decimal. The number must fall in the
     * range [-2^31, 2^31-1]. Any value outside that range will cause the event to be invalid.
     *
     * @param value The event's value as a double. Must be a number.
     * @return An AccountEvent.
     * @throws NumberFormatException if the value is infinity or not a number.
     */
    public AccountEvent setValue(double value) {
        return setValue(BigDecimal.valueOf(value));
    }

    /**
     * Sets the event value.
     * <p/>
     * The event's value will be accurate 6 digits after the decimal. The number must fall in the
     * range [-2^31, 2^31-1]. Any value outside that range will cause the event to be invalid.
     *
     * @param value The event's value as a string. Must contain valid string representation of a big decimal.
     * @return An AccountEvent.
     * @throws NumberFormatException if the event value does not contain a valid string representation
     * of a big decimal.
     */
    public AccountEvent setValue(String value) {
        if (value == null || value.length() == 0) {
            this.value = null;
            return this;
        }

        return setValue(new BigDecimal(value));
    }

    /**
     * Sets the event value.
     * <p/>
     * The event's value will be accurate 6 digits after the decimal. The number must fall in the
     * range [-2^31, 2^31-1]. Any value outside that range will cause the event to be invalid.
     *
     * @param value The event's value as an int.
     * @return An AccountEvent.
     */
    public AccountEvent setValue(int value) {
        return setValue(new BigDecimal(value));
    }

    /**
     * Set the category.
     * </p>
     * If the category exceeds 255 characters it will cause the event to be invalid.
     *
     * @param category The category as a string.
     * @return An AccountEvent.
     */
    public AccountEvent setCategory(String category) {
        this.category = category;
        return this;
    }

    /**
     * Creates and records the custom account event.
     */
    public CustomEvent track() {
        CustomEvent.Builder builder = new CustomEvent.Builder(REGISTERED_ACCOUNT_EVENT);

        if (this.value != null) {
            builder.setEventValue(this.value);
            builder.addProperty(LIFETIME_VALUE, true);
        } else {
            builder.addProperty(LIFETIME_VALUE, false);
        }

        if (this.transactionId != null) {
            builder.setTransactionId(this.transactionId);
        }

        if (this.category != null) {
            builder.addProperty(CATEGORY, this.category);
        }

        return builder.addEvent();
    }
}
