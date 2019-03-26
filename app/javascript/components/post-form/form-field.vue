<template>
  <div class="field">
    <label>{{ label }}</label>
    <textarea
      v-if="useTextarea"
      :value="value"
      @input="$emit('updateField', $event.target.value)"
      :placeholder="placeholder"
      :name="fieldName"
      :required="isRequired"
    />
    <input
      v-else
      type="text"
      :value="value"
      @input="$emit('updateField', $event.target.value)"
      :placeholder="placeholder"
      :name="fieldName"
      :required="isRequired"
    >
    <p
      v-if="errorMessage"
      class="helper-text helper-text-error"
    >{{ label }} {{ errorMessage }}</p>
    <p v-else class="helper-text">{{ helperMessage }}</p>
  </div>
</template>

<script>
export default {
  props: {
    value: String,
    useTextarea: Boolean,
    label: String,
    fieldName: String,
    placeholder: String,
    helperMessage: String,
    errorMessage: String,
    isRequired: Boolean
  },
  methods: {
    updateField(event) {
      this.$emit(`updateField`, event.target.value);
    }
  }
};
</script>
